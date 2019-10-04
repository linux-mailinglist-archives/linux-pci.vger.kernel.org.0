Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF3CB379
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 05:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJDDS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 23:18:58 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:39082 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfJDDS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2019 23:18:58 -0400
X-Greylist: delayed 1918 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 23:18:58 EDT
Received: from [10.8.0.1] (helo=srv.home ident=heh19151)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1iGDZX-0001GQ-TE; Fri, 04 Oct 2019 10:43:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=JOyw9WqbGBm2Mu4SL6cJ20GQPUKDDNmOAM6PypbLkKg=;
        b=NobExJzO4BKQfqxAguTeCdjv1RNo55e1U9Mit0cBCEV57xrPfG/W/vOAqS2cl7a0dGGWVf7xgf6qWj6gmfgzdn/LML1ByU7xWFXH+YmHODudfAfpu3xtA+Ketx1WpvgdpOa7k9BtRRd80z3phUigCAF7do49+VEVd4tZ2osSvSI=;
Subject: Re: [PATCH 1/3] thunderbolt: Read DP IN adapter first two dwords in
 one go
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
References: <20191001102905.21680-1-mika.westerberg@linux.intel.com>
 <20191001102905.21680-2-mika.westerberg@linux.intel.com>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <abad9eb5-ef39-5936-7d9d-bdf53a81a1c4@fnarfbargle.com>
Date:   Fri, 4 Oct 2019 10:43:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191001102905.21680-2-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/10/19 6:29 pm, Mika Westerberg wrote:
> When we discover existing DP tunnels the code checks whether DP IN
> adapter port is enabled by calling tb_dp_port_is_enabled() before it
> continues the discovery process. On Light Ridge (gen 1) controller
> reading only the first dword of the DP IN config space causes subsequent
> access to the same DP IN port path config space to fail or return
> invalid data as can be seen in the below splat:
> 
>    thunderbolt 0000:07:00.0: CFG_ERROR(0:d): Invalid config space or offset
>    Call Trace:
>     tb_cfg_read+0xb9/0xd0
>     __tb_path_deactivate_hop+0x98/0x210
>     tb_path_activate+0x228/0x7d0
>     tb_tunnel_restart+0x95/0x200
>     tb_handle_hotplug+0x30e/0x630
>     process_one_work+0x1b4/0x340
>     worker_thread+0x44/0x3d0
>     kthread+0xeb/0x120
>     ? process_one_work+0x340/0x340
>     ? kthread_park+0xa0/0xa0
>     ret_from_fork+0x1f/0x30
> 
> If both DP In adapter config dwords are read in one go the issue does
> not reproduce. This is likely firmware bug but we can work it around by
> always reading the two dwords in one go. There should be no harm for
> other controllers either so can do it unconditionally.
> 
> Link: https://lkml.org/lkml/2019/8/28/160
> Reported-by: Brad Campbell <lists2009@fnarfbargle.com>

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/thunderbolt/switch.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 410bf1bceeee..8e712fbf8233 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -896,12 +896,13 @@ int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
>    */
>   bool tb_dp_port_is_enabled(struct tb_port *port)
>   {
> -	u32 data;
> +	u32 data[2];
>   
> -	if (tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1))
> +	if (tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
> +			 ARRAY_SIZE(data)))
>   		return false;
>   
> -	return !!(data & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
> +	return !!(data[0] & (TB_DP_VIDEO_EN | TB_DP_AUX_EN));
>   }
>   
>   /**
> @@ -914,19 +915,21 @@ bool tb_dp_port_is_enabled(struct tb_port *port)
>    */
>   int tb_dp_port_enable(struct tb_port *port, bool enable)
>   {
> -	u32 data;
> +	u32 data[2];
>   	int ret;
>   
> -	ret = tb_port_read(port, &data, TB_CFG_PORT, port->cap_adap, 1);
> +	ret = tb_port_read(port, data, TB_CFG_PORT, port->cap_adap,
> +			   ARRAY_SIZE(data));
>   	if (ret)
>   		return ret;
>   
>   	if (enable)
> -		data |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
> +		data[0] |= TB_DP_VIDEO_EN | TB_DP_AUX_EN;
>   	else
> -		data &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
> +		data[0] &= ~(TB_DP_VIDEO_EN | TB_DP_AUX_EN);
>   
> -	return tb_port_write(port, &data, TB_CFG_PORT, port->cap_adap, 1);
> +	return tb_port_write(port, data, TB_CFG_PORT, port->cap_adap,
> +			     ARRAY_SIZE(data));
>   }
>   
>   /* switch utility functions */
> 

