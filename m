Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596869739A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 02:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjBOB1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 20:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjBOB1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 20:27:17 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5231E39
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676424428; x=1707960428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rvloK5ngdtPCbJug6sOHC6AFBm+SqF5jOZbIHY27apo=;
  b=Fg1BHrLQNWTBMvIkv1gP0WyXhlGXBZohqKL1i408IC1WuUxI3UDGtfeL
   jY6eIeDZOo3Tau0mY/cqxlNcxuC8POhXpqXmTgJnZo0DzYD5o0XQ/K722
   0bAIqJ5ysrL24BYP1dOOILK8Z/bq8bf+LjgsgAE3l9keggnVJPn3eZJd3
   YJJAaPnsaK5E2zKxvrttbcDx72heMvfnFRcHzgrRMCHy/HyWDvkRPLnmr
   MyfXQmA3V8wXLskFDtaR1yvYUwXHxAyXnyqMLD32633NdXDVpb66QoGdU
   IKn80jNd2VBq5unvG0uH+L581iq6QZoFSePc77f4Z/6t2Q+GiYIbiwOSs
   A==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="221622426"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 09:26:58 +0800
IronPort-SDR: C+59oEYYDgbWGmYmOQASvXe5quLHtdnfhD3rOUuAfTsweJ/L5KEgVbJyimJ0F+RAOzwZjguiWM
 bGhy07Fi8JnDQuaIEOMud22e3GAUXU67pYb3lskFRG65D0haXkG1bn9alErxuFQjnXqEEqhmlw
 XfL03LFPWiVNcXCgEVCtE5Jzhd9aO5gQVbEIbF8fwf7bTDUw9mwYnednwZi7xmMAVVLdoNUohH
 pVI9dXodSLBN8Tl93NJyOFd1NtNW7FiybJNO5aKtVCpH/PvpsdpRHPXqljQEGSXe23e5whBhgB
 4V0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 16:44:06 -0800
IronPort-SDR: /rqm95Q0bgW7zQXu256W+HRxvLMw2R2zyeNdmixaFZVH2liaOy3Uj9A69x1A741hDlm5/G/u4e
 gWcRhCCJwxONwhRhSli5W7+E88OGJZ7QuWOkSs0583N32pjeAlibOX39z66IpdLAEMivt0cl1b
 CXOcl0yS7hFGqg0bRJ5ukjP0YwyA0EdkEsR4lTdbIFEcX0YA3Q4Lj7pPblwv0prjkE9okDJuu9
 jQLrX5AJTqR0B1PIfp7J7PCckr0KsJBkQKd8X//MJIOn2VW0zCXn39bCInLay3YIW2pmKaqAuE
 rw0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 17:26:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGgR62xLxz1RvTp
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 17:26:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676424417; x=1679016418; bh=rvloK5ngdtPCbJug6sOHC6AFBm+SqF5jOZb
        IHY27apo=; b=XROi/FN9X2gcoDt8oVw1OMORiTAwQFNEE2nYYXOd0EwCWAdf1Z3
        4p1O4qn0lqAlbnmL1rz3FlOi4yfBD8I0ck7c4yn3Wlt+/oTj7EHGSkWW/vOfntyU
        eNZavmZ9BWy66mJQ7x4sjzozwiqsR9rfMbbrtpAqb+K7uLlM8RI5zk4ESTC0Wj0/
        4kq39GdDjT9YRXEwh/FeajOcOkYuAL9dewJD66hqlXUao7ucyi3RmAdsL8KMtOc9
        j8DQUrhWMTPWiFFAmwpMaFxFgrSo1JpDp2yTREjxPKBmFuChSr03MtIlLajaa7fk
        Kwpt3AAMS+0JKDQONC9gB7HGYpWLLnVcNpQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XcmLSiYmpP_b for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 17:26:57 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGgR14p3Jz1RvLy;
        Tue, 14 Feb 2023 17:26:53 -0800 (PST)
Message-ID: <67d08dce-4610-5e34-853a-1d09c5389607@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 10:26:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/9] PCI: rockchip: Fix legacy IRQ generation for
 RK3399 PCIe endpoint core
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-8-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-8-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Fix legacy IRQ generation for RK3399 PCIe endpoint core according to
> the technical reference manual (TRM). Assert and deassert legacy
> interrupt (INTx) through the legacy interrupt control register
> ("PCIE_CLIENT_LEGACY_INT_CTRL") instead of manually generating a PCIe
> message. The generation of the legacy interrupt was tested and validated
> with the PCIe endpoint test driver.
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Some nits below. But otherwise works fine for me.

> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 38 +++++------------------
>  drivers/pci/controller/pcie-rockchip.h    |  6 ++++
>  2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index cbc281a6a..ca5b363ba 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -328,45 +328,23 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
>  					 u8 intx, bool is_asserted)
>  {
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u32 r = ep->max_regions - 1;
> -	u32 offset;
> -	u32 status;
> -	u8 msg_code;
> -
> -	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
> -		     ep->irq_pci_fn != fn)) {
> -		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> -					     AXI_WRAPPER_NOR_MSG,
> -					     ep->irq_phys_addr, 0, 0);
> -		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
> -		ep->irq_pci_fn = fn;
> -	}
>  
>  	intx &= 3;
>  	if (is_asserted) {
>  		ep->irq_pending |= BIT(intx);
> -		msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;
>  	} else {
>  		ep->irq_pending &= ~BIT(intx);
> -		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
>  	}
>  
> -	status = rockchip_pcie_read(rockchip,
> -				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> -				    ROCKCHIP_PCIE_EP_CMD_STATUS);
> -	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
> -
> -	if ((status != 0) ^ (ep->irq_pending != 0)) {
> -		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
> -		rockchip_pcie_write(rockchip, status,
> -				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> -				    ROCKCHIP_PCIE_EP_CMD_STATUS);
> +	if (is_asserted) {
> +		rockchip_pcie_write(rockchip,
> +			PCIE_CLIENT_INT_IN_ASSERT | PCIE_CLIENT_INT_PEND_ST_PEND,
> +			PCIE_CLIENT_LEGACY_INT_CTRL);
> +	} else {
> +		rockchip_pcie_write(rockchip,
> +			PCIE_CLIENT_INT_IN_DEASSERT | PCIE_CLIENT_INT_PEND_ST_NORMAL,
> +			PCIE_CLIENT_LEGACY_INT_CTRL);
>  	}

With this change, you have now twice "if (is_asserted) {", which is not
necessary. You can simplify the code a bit:

static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep,
					 u8 fn, u8 intx, bool do_assert)
{

        u8 msg_code;



        intx &= 3;

        if (do_assert) {

                ep->irq_pending |= BIT(intx);

                msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;

                rockchip_pcie_write(&ep->rockchip,

                        PCIE_CLIENT_INT_IN_ASSERT |

                        PCIE_CLIENT_INT_PEND_ST_PEND,

                        PCIE_CLIENT_LEGACY_INT_CTRL);

                return;

        }



        ep->irq_pending &= ~BIT(intx);

        msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;

        rockchip_pcie_write(&ep->rockchip,

                            PCIE_CLIENT_INT_IN_DEASSERT |

                            PCIE_CLIENT_INT_PEND_ST_NORMAL,

                            PCIE_CLIENT_LEGACY_INT_CTRL);

}

Note also the renaming of the argument "is_asserted" to "do_assert". The
name is_asserted is badly misleading considering the english meaning given
that it is true when we *must* do the assert and false when we must
deassert. So do_assert as a name better match the use of that argument I
think.

> -
> -	offset =
> -	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
> -	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
> -	writel(0, ep->irq_cpu_addr + offset);
>  }
>  
>  static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 72e427a0f..e90c2a2b8 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -39,6 +39,12 @@
>  #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>  #define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
> +#define PCIE_CLIENT_LEGACY_INT_CTRL		(PCIE_CLIENT_BASE + 0x0c)
> +#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
> +#define   PCIE_CLIENT_INT_IN_DEASSERT	HIWORD_UPDATE(0x0002, 0)
> +#define   PCIE_CLIENT_INT_PEND_ST_PEND	HIWORD_UPDATE_BIT(0x0001)
> +#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
> +#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
>  #define   PCIE_CLIENT_PHY_ST			BIT(12)
>  #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
>  #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)

-- 
Damien Le Moal
Western Digital Research

