Return-Path: <linux-pci+bounces-16132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7293A9BE846
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960D71C20B17
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFA1DF994;
	Wed,  6 Nov 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi2ulaXy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3B1DF740;
	Wed,  6 Nov 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895775; cv=none; b=CvcGIjlb67hqA+mLWxYdk7PY+DKiZ6XzYycrpfxuw8tZYR7Ih4Day4GTLUJRK7zSINNu7Hcd54A4XGTy/R2VjoCjugiXxMiOxzHww6MAGK1G6T52N1Mp9+Q9B4PCIEWHz+2sNdeKiz0J4g2T7d5it7gQHDfkz7+SkdVQteTQbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895775; c=relaxed/simple;
	bh=gWbltpO85gNh0+8fPX+Y+O7tCvXVbND3N49beyqNlVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4RBj4+CH/LADWZQ7FHGoXr2Q90av3bScHttnUsQoI2yFGm+VHvuaoSXOGNz6Se6VcwmwMBV7sc9R8Yy5vpYQF6l9ElnzxAEBQSb7sML+t7tgH57M/8Hp/s96986Z2WOYel6Z3xHSSg9tuf9AEF6sgffuomyaRy51OrDPjurSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi2ulaXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB68C4CED3;
	Wed,  6 Nov 2024 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730895775;
	bh=gWbltpO85gNh0+8fPX+Y+O7tCvXVbND3N49beyqNlVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wi2ulaXywHWspAgnHRssfY2Vxg6d24N81//l5R7fZCCDyxsSEEi6QKpFf5UmuzST9
	 nDRnYMeRFQKMvaQCH0NAmRf8jGomRUId0CE0yOOkqYMXe+OXkqhG3KKxFapNkbXWcA
	 LsxeKiioIWTBNgH8C6TyFZiPQjvHK/4N3aGtNmNWtyCOL3F2PghUfCrL3/xhMKzKM8
	 dokmgw1M6Ox8bzSiVUDRW53EwwpYlxOL+NpKz+tidH7hoTg4Vw8YTimXP82FSbwgx+
	 MqYSu7d0MDOcxyT+tAWAgjCN3q/rW9plMFB3oT6q3XhAwpvw4yzNRFiGbA9AfylwUu
	 hPqVVIxSMBbkw==
Date: Wed, 6 Nov 2024 14:22:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241106122251.GC5006@unreal>
References: <20241106002625.1857904-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106002625.1857904-1-sanman.p211993@gmail.com>

On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> Add PCIe hardware statistics support to the fbnic driver. These stats
> provide insight into PCIe transaction performance and error conditions,
> including, read/write and completion TLP counts and DWORD counts and
> debug counters for tag, completion credit and NP credit exhaustion
> 
> The stats are exposed via ethtool and can be used to monitor PCIe
> performance and debug PCIe issues.

And how does PCIe statistics belong to ethtool?

This PCIe statistics to debug PCIe errors and arguably should be part of
PCI core and not hidden in netdev tool.

Thanks

> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  17 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
>  8 files changed, 278 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> index 32ff114f5c26..31c6371c45f8 100644
> --- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> +++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> @@ -27,3 +27,30 @@ driver takes over.
>  devlink dev info provides version information for all three components. In
>  addition to the version the hg commit hash of the build is included as a
>  separate entry.
> +
> +
> +PCIe Statistics
> +---------------
> +
> +The fbnic driver exposes PCIe hardware performance statistics through ethtool.
> +These statistics provide insights into PCIe transaction behavior and potential
> +performance bottlenecks.
> +
> +Statistics Categories
> +
> +1. PCIe Transaction Counters:
> +
> +   These counters track PCIe transaction activity:
> +        - pcie_ob_rd_tlp: Outbound read Transaction Layer Packets count
> +        - pcie_ob_rd_dword: DWORDs transferred in outbound read transactions
> +        - pcie_ob_wr_tlp: Outbound write Transaction Layer Packets count
> +        - pcie_ob_wr_dword: DWORDs transferred in outbound write transactions
> +        - pcie_ob_cpl_tlp: Outbound completion TLP count
> +        - pcie_ob_cpl_dword: DWORDs transferred in outbound completion TLPs
> +
> +2. PCIe Resource Monitoring:
> +
> +   These counters indicate PCIe resource exhaustion events:
> +        - pcie_ob_rd_no_tag: Read requests dropped due to tag unavailability
> +        - pcie_ob_rd_no_cpl_cred: Read requests dropped due to completion credit exhaustion
> +        - pcie_ob_rd_no_np_cred: Read requests dropped due to non-posted credit exhaustion
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index fec567c8fe4a..a8fedff48103 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -6,6 +6,7 @@
> 
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/netdevice.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index 79cdd231d327..9ee562acbdfc 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -882,6 +882,45 @@ enum {
>  #define FBNIC_MAX_QUEUES		128
>  #define FBNIC_CSR_END_QUEUE	(0x40000 + 0x400 * FBNIC_MAX_QUEUES - 1)
> 
> +#define FBNIC_TCE_DROP_CTRL		0x0403d		/* 0x100f0*/
> +
> +/* PUL User Registers*/
> +#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
> +					0x3106e		/* 0xc41b8 */
> +#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
> +					0x31070		/* 0xc41c0 */
> +#define FBNIC_PUL_USER_OB_RD_DWORD_CNT_63_32 \
> +					0x31071		/* 0xc41c4 */
> +#define FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0 \
> +					0x31072		/* 0xc41c8 */
> +#define FBNIC_PUL_USER_OB_WR_TLP_CNT_63_32 \
> +					0x31073		/* 0xc41cc */
> +#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0 \
> +					0x31074		/* 0xc41d0 */
> +#define FBNIC_PUL_USER_OB_WR_DWORD_CNT_63_32 \
> +					0x31075		/* 0xc41d4 */
> +#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0 \
> +					0x31076		/* 0xc41d8 */
> +#define FBNIC_PUL_USER_OB_CPL_TLP_CNT_63_32 \
> +					0x31077		/* 0xc41dc */
> +#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0 \
> +					0x31078		/* 0xc41e0 */
> +#define FBNIC_PUL_USER_OB_CPL_DWORD_CNT_63_32 \
> +					0x31079		/* 0xc41e4 */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0 \
> +					0x3107a		/* 0xc41e8 */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_63_32 \
> +					0x3107b		/* 0xc41ec */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0 \
> +					0x3107c		/* 0xc41f0 */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_63_32 \
> +					0x3107d		/* 0xc41f4 */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0 \
> +					0x3107e		/* 0xc41f8 */
> +#define FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_63_32 \
> +					0x3107f		/* 0xc41fc */
> +#define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
> +
>  /* BAR 4 CSRs */
> 
>  /* The IPC mailbox consists of 32 mailboxes, with each mailbox consisting
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 1117d5a32867..9f590a42a9df 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -6,6 +6,39 @@
>  #include "fbnic_netdev.h"
>  #include "fbnic_tlv.h"
> 
> +struct fbnic_stat {
> +	u8 string[ETH_GSTRING_LEN];
> +	unsigned int size;
> +	unsigned int offset;
> +};
> +
> +#define FBNIC_STAT_FIELDS(type, name, stat) { \
> +	.string = name, \
> +	.size = sizeof_field(struct type, stat), \
> +	.offset = offsetof(struct type, stat), \
> +}
> +
> +/* Hardware statistics not captured in rtnl_link_stats */
> +#define FBNIC_HW_STAT(name, stat) \
> +	FBNIC_STAT_FIELDS(fbnic_hw_stats, name, stat)
> +
> +static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
> +	/* PCIE */
> +	FBNIC_HW_STAT("pcie_ob_rd_tlp", pcie.ob_rd_tlp),
> +	FBNIC_HW_STAT("pcie_ob_rd_dword", pcie.ob_rd_dword),
> +	FBNIC_HW_STAT("pcie_ob_wr_tlp", pcie.ob_wr_tlp),
> +	FBNIC_HW_STAT("pcie_ob_wr_dword", pcie.ob_wr_dword),
> +	FBNIC_HW_STAT("pcie_ob_cpl_tlp", pcie.ob_cpl_tlp),
> +	FBNIC_HW_STAT("pcie_ob_cpl_dword", pcie.ob_cpl_dword),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_tag", pcie.ob_rd_no_tag),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_cpl_cred", pcie.ob_rd_no_cpl_cred),
> +	FBNIC_HW_STAT("pcie_ob_rd_no_np_cred", pcie.ob_rd_no_np_cred),
> +};
> +
> +#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
> +#define FBNIC_HW_STATS_LEN \
> +	(FBNIC_HW_FIXED_STATS_LEN)
> +
>  static int
>  fbnic_get_ts_info(struct net_device *netdev,
>  		  struct kernel_ethtool_ts_info *tsinfo)
> @@ -51,6 +84,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
>  		*stat = counter->value;
>  }
> 
> +static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> +{
> +	int i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> +			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> +		break;
> +	}
> +}
> +
> +static int fbnic_get_sset_count(struct net_device *dev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return FBNIC_HW_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void fbnic_get_ethtool_stats(struct net_device *dev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(dev);
> +	const struct fbnic_stat *stat;
> +	int i;
> +
> +	fbnic_get_hw_stats(fbn->fbd);
> +
> +	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> +		stat = &fbnic_gstrings_hw_stats[i];
> +		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> +	}
> +}
> +
>  static void
>  fbnic_get_eth_mac_stats(struct net_device *netdev,
>  			struct ethtool_eth_mac_stats *eth_mac_stats)
> @@ -117,10 +187,13 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
>  }
> 
>  static const struct ethtool_ops fbnic_ethtool_ops = {
> -	.get_drvinfo		= fbnic_get_drvinfo,
>  	.get_ts_info		= fbnic_get_ts_info,
> -	.get_ts_stats		= fbnic_get_ts_stats,
> +	.get_drvinfo		= fbnic_get_drvinfo,
> +	.get_strings		= fbnic_get_strings,
> +	.get_sset_count		= fbnic_get_sset_count,
> +	.get_ethtool_stats	= fbnic_get_ethtool_stats,
>  	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
> +	.get_ts_stats		= fbnic_get_ts_stats,
>  };
> 
>  void fbnic_set_ethtool_ops(struct net_device *dev)
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> index a0acc7606aa1..eb19b49fe306 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> @@ -25,3 +25,117 @@ u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
>  	 */
>  	return ((u64)upper << 32);
>  }
> +
> +static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> +				struct fbnic_stat_counter *stat)
> +{
> +	/* Record initial counter values and compute deltas from there to ensure
> +	 * stats start at 0 after reboot/reset. This avoids exposing absolute
> +	 * hardware counter values to userspace.
> +	 */
> +	stat->u.old_reg_value_64 = fbnic_stat_rd64(fbd, reg, offset);
> +}
> +
> +static void fbnic_hw_stat_rd64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> +			       struct fbnic_stat_counter *stat)
> +{
> +	u64 new_reg_value;
> +
> +	new_reg_value = fbnic_stat_rd64(fbd, reg, offset);
> +	stat->value += new_reg_value - stat->u.old_reg_value_64;
> +	stat->u.old_reg_value_64 = new_reg_value;
> +}
> +
> +static void fbnic_reset_pcie_stats_asic(struct fbnic_dev *fbd,
> +					struct fbnic_pcie_stats *pcie)
> +{
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0,
> +			    1,
> +			    &pcie->ob_rd_tlp);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0,
> +			    1,
> +			    &pcie->ob_rd_dword);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0,
> +			    1,
> +			    &pcie->ob_cpl_tlp);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0,
> +			    1,
> +			    &pcie->ob_cpl_dword);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0,
> +			    1,
> +			    &pcie->ob_wr_tlp);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0,
> +			    1,
> +			    &pcie->ob_wr_dword);
> +
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0,
> +			    1,
> +			    &pcie->ob_rd_no_tag);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0,
> +			    1,
> +			    &pcie->ob_rd_no_cpl_cred);
> +	fbnic_hw_stat_rst64(fbd,
> +			    FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0,
> +			    1,
> +			    &pcie->ob_rd_no_np_cred);
> +}
> +
> +static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
> +					struct fbnic_pcie_stats *pcie)
> +{
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0,
> +			   1,
> +			   &pcie->ob_rd_tlp);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0,
> +			   1,
> +			   &pcie->ob_rd_dword);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_WR_TLP_CNT_31_0,
> +			   1,
> +			   &pcie->ob_wr_tlp);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_WR_DWORD_CNT_31_0,
> +			   1,
> +			   &pcie->ob_wr_dword);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_CPL_TLP_CNT_31_0,
> +			   1,
> +			   &pcie->ob_cpl_tlp);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_CPL_DWORD_CNT_31_0,
> +			   1,
> +			   &pcie->ob_cpl_dword);
> +
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_RD_DBG_CNT_TAG_31_0,
> +			   1,
> +			   &pcie->ob_rd_no_tag);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_RD_DBG_CNT_CPL_CRED_31_0,
> +			   1,
> +			   &pcie->ob_rd_no_cpl_cred);
> +	fbnic_hw_stat_rd64(fbd,
> +			   FBNIC_PUL_USER_OB_RD_DBG_CNT_NP_CRED_31_0,
> +			   1,
> +			   &pcie->ob_rd_no_np_cred);
> +}
> +
> +void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
> +{
> +	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
> +}
> +
> +void fbnic_get_hw_stats(struct fbnic_dev *fbd)
> +{
> +	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> index 30348904b510..0be403ac211b 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> @@ -11,6 +11,21 @@ struct fbnic_stat_counter {
>  	bool reported;
>  };
> 
> +struct fbnic_hw_stat {
> +	struct fbnic_stat_counter frames;
> +	struct fbnic_stat_counter bytes;
> +};
> +
> +struct fbnic_pcie_stats {
> +	struct fbnic_stat_counter ob_rd_tlp, ob_rd_dword;
> +	struct fbnic_stat_counter ob_wr_tlp, ob_wr_dword;
> +	struct fbnic_stat_counter ob_cpl_tlp, ob_cpl_dword;
> +
> +	struct fbnic_stat_counter ob_rd_no_tag;
> +	struct fbnic_stat_counter ob_rd_no_cpl_cred;
> +	struct fbnic_stat_counter ob_rd_no_np_cred;
> +};
> +
>  struct fbnic_eth_mac_stats {
>  	struct fbnic_stat_counter FramesTransmittedOK;
>  	struct fbnic_stat_counter FramesReceivedOK;
> @@ -33,8 +48,10 @@ struct fbnic_mac_stats {
> 
>  struct fbnic_hw_stats {
>  	struct fbnic_mac_stats mac;
> +	struct fbnic_pcie_stats pcie;
>  };
> 
>  u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
> 
> +void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
>  void fbnic_get_hw_stats(struct fbnic_dev *fbd);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index c08798fad203..9cb850b78795 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -627,6 +627,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
> 
>  	fbnic_reset_queues(fbn, default_queues, default_queues);
> 
> +	/* Capture snapshot of hardware stats so netdev can calculate delta */
> +	fbnic_reset_hw_stats(fbd);
> +
>  	fbnic_reset_indir_tbl(fbn);
>  	fbnic_rss_key_fill(fbn->rss_key);
>  	fbnic_rss_init_en_mask(fbn);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index 2de5a6fde7e8..cd1fe1114819 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -455,6 +455,8 @@ static void __fbnic_pm_attach(struct device *dev)
>  	struct net_device *netdev = fbd->netdev;
>  	struct fbnic_net *fbn;
> 
> +	fbnic_reset_hw_stats(fbd);
> +
>  	if (fbnic_init_failure(fbd))
>  		return;
> 
> --
> 2.43.5
> 

