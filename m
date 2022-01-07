Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD25487C4F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiAGSpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 13:45:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49794 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiAGSpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 13:45:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F71D6171F;
        Fri,  7 Jan 2022 18:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3BC36AE9;
        Fri,  7 Jan 2022 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641581150;
        bh=ldytF5XvdxNK25AZ/Rg8qis5NU/+Yn1ZpYM0pkB0Gdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jlD4gPcExL33TD3RD5A3nYCDHSnixX9+PDt9isYN1GMzPah1POJVkEYto52BrCKab
         JPEq+L2/1tkyOmdohrl+MxGV0MjO5iQ8GzbqokF91D2cZGl+/f4jievzZMj1t6xPkC
         uW2WgTCrgM1ChY9nCpESLYXq/HX0gjZcURkcP/3PGn9P1e6f0NPUJW/AA/Kuu2q08p
         lkFjRAv3UY+zUyvxxnlo+CuiL4Z38yvaqjSunxXmC1m6ZBYa6zEW+c2RTwSeK86PQC
         IMmX68TUeOLGrqHr6vYKMC63w7CyU538LQx01ZM7qIuGvkhJujy2Oh45Ywkl4gM6EQ
         2KVRxASnQManw==
Date:   Fri, 7 Jan 2022 12:45:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] PCI: mvebu: Handle invalid size of read config
 request
Message-ID: <20220107184548.GA390934@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125124605.25915-5-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 25, 2021 at 01:45:54PM +0100, Pali Rohár wrote:
> Function mvebu_pcie_hw_rd_conf() does not handle invalid size. So correctly
> set read value to all-ones and return appropriate error return value
> PCIBIOS_BAD_REGISTER_NUMBER like in mvebu_pcie_hw_wr_conf() function.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org

Is there a bug that this fixes?  If not, I would drop the stable tag
(as I see Lorenzo already did, thanks!).

> ---
>  drivers/pci/controller/pci-mvebu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 08274132cdfb..19c6ee298442 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -261,6 +261,9 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
>  	case 4:
>  		*val = readl_relaxed(conf_data);
>  		break;
> +	default:
> +		*val = 0xffffffff;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

Might be the right thing to do, but there are many config accessors
that do not set *val to ~0 before returning
PCIBIOS_BAD_REGISTER_NUMBER:

  pci_bus_read_config_byte (and word, dword)  # PCI_OP_READ(), *val unchanged
  pci_generic_config_read                     # *val = 32-bit value
  pci_user_read_config_byte (...)             # PCI_USER_READ_CONFIG(), *val unchanged
  sh7786_pcie_read                            # *val unchanged
  dw_pcie_read                                # *val = 0
  mobiveil_pcie_read                          # *val = 0
  faraday_raw_pci_read_config                 # *val = 32-bit value
  ixp4xx_pci_read_config                      # *val unchanged
  orion5x_pci_hw_rd_conf                      # *val = 32-bit value
  orion_pcie_rd_conf                          # *val = 32-bit value
  bonito64_pcibios_read                       # *val = 32-bit value
  loongson_pcibios_read                       # *val = 32-bit value
  msc_pcibios_read                            # *val = 32-bit value
  ar724x_pci_read                             # *val unchanged
  bcm1480_pcibios_read                        # *val = 32-bit value
  _altera_pcie_cfg_read                       # *val = 32-bit value
  rockchip_pcie_rd_own_conf                   # *val = 0
  rockchip_pcie_rd_other_conf                 # *val = 0
  pci_bridge_emul_conf_read                   # may depend on op?

There are more, but I got tired of looking.  I actually didn't see any
that set *val to ~0.

I think the check in PCI_OP_READ() means that most accessors will
never see an invalid "size".

>  	}
>  
>  	return PCIBIOS_SUCCESSFUL;
> -- 
> 2.20.1
> 
