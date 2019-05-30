Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB02FF60
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfE3PZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 11:25:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38712 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfE3PZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 11:25:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F61E341;
        Thu, 30 May 2019 08:25:52 -0700 (PDT)
Received: from redmoon (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0CC3F59C;
        Thu, 30 May 2019 08:25:51 -0700 (PDT)
Date:   Thu, 30 May 2019 16:25:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lftan.linux@gmail.com
Subject: Re: [PATCH 1/2] PCI: altera: Fix configuration type based on
 secondary number
Message-ID: <20190530152548.GD13993@redmoon>
References: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
 <1558678046-4052-2-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558678046-4052-2-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 02:07:25PM +0800, Ley Foon Tan wrote:
> This fix issue when access config from PCIe switch.
> 
> Stratix 10 PCIe controller does not support Type 1 to Type 0 conversion
> as previous version (V1) does.
> 
> The PCIe controller need to send Type 0 config TLP if the targeting bus
> matches with the secondary bus number, which is when the TLP is targeting
> the immediate device on the link.
> 
> The PCIe controller send Type 1 config TLP if the targeting bus is
> larger than the secondary bus, which is when the TLP is targeting the
> device not immediate on the link.
> 
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 27222071ace7..047bcc214f9b 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -44,6 +44,8 @@
>  #define S10_RP_RXCPL_STATUS		0x200C
>  #define S10_RP_CFG_ADDR(pcie, reg)	\
>  	(((pcie)->hip_base) + (reg) + (1 << 20))
> +#define S10_RP_SECONDARY(pcie)		\
> +	readb(S10_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
>  
>  /* TLP configuration type 0 and 1 */
>  #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
> @@ -63,6 +65,14 @@
>  	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0		\
>  				: pcie->pcie_data->cfgwr1) << 24) |	\
>  				TLP_PAYLOAD_SIZE)
> +#define S10_TLP_CFGRD_DW0(pcie, bus)					\
> +	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgrd0	\
> +				: pcie->pcie_data->cfgrd1) << 24) |	\
> +				TLP_PAYLOAD_SIZE)
> +#define S10_TLP_CFGWR_DW0(pcie, bus)					\
> +	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgwr0	\
> +				: pcie->pcie_data->cfgwr1) << 24) |	\
> +				TLP_PAYLOAD_SIZE)
>  #define TLP_CFG_DW1(pcie, tag, be)	\
>  	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
>  #define TLP_CFG_DW2(bus, devfn, offset)	\
> @@ -327,7 +337,11 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  {
>  	u32 headers[TLP_HDR_SIZE];
>  
> -	headers[0] = TLP_CFGRD_DW0(pcie, bus);
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
> +		headers[0] = TLP_CFGRD_DW0(pcie, bus);
> +	else
> +		headers[0] = S10_TLP_CFGRD_DW0(pcie, bus);
> +
>  	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
>  	headers[2] = TLP_CFG_DW2(bus, devfn, where);
>  
> @@ -342,7 +356,11 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  	u32 headers[TLP_HDR_SIZE];
>  	int ret;
>  
> -	headers[0] = TLP_CFGWR_DW0(pcie, bus);
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
> +		headers[0] = TLP_CFGWR_DW0(pcie, bus);
> +	else
> +		headers[0] = S10_TLP_CFGWR_DW0(pcie, bus);
> +

Why don't you rewrite all these macros as an eg:

static inline u32 get_tlp_header()
{}

where you can also handle the version and everything needed to
detect what header should be set-up ?

Lorenzo

>  	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
>  	headers[2] = TLP_CFG_DW2(bus, devfn, where);
>  
> -- 
> 2.19.0
> 
