Return-Path: <linux-pci+bounces-31765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282EAFE8B5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE435600CD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95A2D94BE;
	Wed,  9 Jul 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFpa7akL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61672D6631;
	Wed,  9 Jul 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063644; cv=none; b=R2HdirCgKcck64kaCmw47o0TzR1egxR38F7ZFjc8f+znHJh341CphIN+3XxWVhJ/U5UuHTXUGMLSJPlEUJWgsbwB+XCfJgC+SuMhAaIqUMv0ReJ2SQgcGyPdFKsbg7TjFA8vBCUnnqGSPy0BgKXkxl2iUo5GVmjGmjepYQhf7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063644; c=relaxed/simple;
	bh=UNteH8MyHXiNBHTEmoU7+5E+nqt7sFjow0ifKuy1UtE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XwyKBtpRg+zZTJSIoNBTYe2hQp6TUHDlPwBAZJUxRZRTmGH6sfy46Y255Jr6PcPoNnhNWCqgJNBaADKb2k9hF9NqZPaASUf89Xioyzr62XE3UFSSmM3c2Woh2cXAjHzpLWwa3h01A1jg76c4sfh3oaqxNq4qwFgjsjqhtCZotgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFpa7akL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752063643; x=1783599643;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UNteH8MyHXiNBHTEmoU7+5E+nqt7sFjow0ifKuy1UtE=;
  b=GFpa7akLw/nvC2a9JeIdOMr1U+PrHI+I/c+h56dwCCqC7EYWCX6VWQRg
   RtE6pAtEcQFsiB8b6glV7Wg4lii8E26cbsiqaJRLEtySVGTfaqPmaUnyh
   Xi2P57usOPTHR3D8dkXvxgzkoJJx4V9gBT1W70Rr2zqkJdblVzhON2U7L
   wS+C3xbvHJRGMnawmOsvcS9tVSgCd9mbB87w9Zu/Ypkq82/82ubmNefQ5
   O0SD/g4EmoW1lKU7Ch7vV+ymbPX4AWHivp2jXB3OZFbV7BUReX7XRuiZh
   quz/byeoKaM/BOBJXlYJi1syUONOZfQsURg2Ib55xsi529XCm92mttaAJ
   Q==;
X-CSE-ConnectionGUID: bOlQhXwDRL69kJPlJiqHJA==
X-CSE-MsgGUID: 2gOY0nqfTjeIHJLwGgAObQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71907248"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71907248"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 05:20:42 -0700
X-CSE-ConnectionGUID: 91ZRmtK3R1Ww85xwUSkIDw==
X-CSE-MsgGUID: JL+YOArQQcKFgvjLdZ5K7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160029712"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 05:20:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Jul 2025 15:20:32 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
In-Reply-To: <5625ffa1-f952-4646-a17a-fbbfffcdba2a@oss.qualcomm.com>
Message-ID: <4c68074e-5809-bc4c-185a-88ddcb81f31b@linux.intel.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com> <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com> <ttjbjmixxbzatcfthaucuy3j4hosu4azpizes6ptxjnkzsawa5@5axodfdyjff2> <5625ffa1-f952-4646-a17a-fbbfffcdba2a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Jul 2025, Krishna Chaitanya Chundru wrote:
> On 7/8/2025 10:06 PM, Manivannan Sadhasivam wrote:
> > On Mon, Jun 09, 2025 at 04:21:24PM GMT, Krishna Chaitanya Chundru wrote:
> > > From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> > > 
> > > As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
> > > located after the ERDB array. The location of this group of registers is
> > > indicated by the MISCOFF register. Each capability has a capability ID to
> > > determine which functionality is supported and each capability will point
> > > to the next capability supported.
> > > 
> > > Add a basic function to read those capabilities offsets.
> > > 
> > > Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> > > Signed-off-by: Krishna Chaitanya Chundru
> > > <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/bus/mhi/common.h    | 13 +++++++++++++
> > >   drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
> > >   2 files changed, 47 insertions(+)
> > > 
> > > diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> > > index
> > > dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd
> > > 100644
> > > --- a/drivers/bus/mhi/common.h
> > > +++ b/drivers/bus/mhi/common.h
> > > @@ -16,6 +16,7 @@
> > >   #define MHICFG				0x10
> > >   #define CHDBOFF				0x18
> > >   #define ERDBOFF				0x20
> > > +#define MISCOFF				0x24
> > >   #define BHIOFF				0x28
> > >   #define BHIEOFF				0x2c
> > >   #define DEBUGOFF			0x30
> > > @@ -113,6 +114,9 @@
> > >   #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
> > >   #define MHISTATUS_SYSERR_MASK		BIT(2)
> > >   #define MHISTATUS_READY_MASK		BIT(0)
> > > +#define MISC_CAP_MASK			GENMASK(31, 0)
> > > +#define CAP_CAPID_MASK			GENMASK(31, 24)
> > > +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
> > >     /* Command Ring Element macros */
> > >   /* No operation command */
> > > @@ -204,6 +208,15 @@
> > >   #define MHI_RSCTRE_DATA_DWORD1
> > > cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
> > >   							       MHI_PKT_TYPE_COALESCING))
> > >   +enum mhi_capability_type {
> > > +	MHI_CAP_ID_INTX = 0x1,
> > > +	MHI_CAP_ID_TIME_SYNC = 0x2,
> > > +	MHI_CAP_ID_BW_SCALE = 0x3,
> > > +	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
> > > +	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
> > > +	MHI_CAP_ID_MAX,
> > > +};
> > > +
> > >   enum mhi_pkt_type {
> > >   	MHI_PKT_TYPE_INVALID = 0x0,
> > >   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> > > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > > index
> > > 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be
> > > 100644
> > > --- a/drivers/bus/mhi/host/init.c
> > > +++ b/drivers/bus/mhi/host/init.c
> > > @@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller
> > > *mhi_cntrl)
> > >   	return ret;
> > >   }
> > >   +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32
> > > capability, u32 *offset)
> > > +{
> > > +	u32 val, cur_cap, next_offset;
> > > +	int ret;
> > > +
> > > +	/* Get the first supported capability offset */
> > > +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
> > > MISC_CAP_MASK, offset);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*offset = (__force u32)le32_to_cpu(*offset);
> > 
> > Why do you need __force attribute? What does it suppress? Is it because the
> > pointer is not le32?
> > 
> yes to suppress warnings.

I'm pretty sure sparce with endianness checking won't be happy with that 
construct as you pass u32 where le32_to_cpu() expects __le32. Have you 
checked this with sparse? (It might not check endianness with default args.)

> > > +	do {
> > > +		if (*offset >= mhi_cntrl->reg_len)
> > > +			return -ENXIO;
> > > +
> > > +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		val = (__force u32)le32_to_cpu(val);
> > > +		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
> > > +		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
> > > +		if (cur_cap >= MHI_CAP_ID_MAX)
> > > +			return -ENXIO;
> > > +
> > > +		if (cur_cap == capability)
> > > +			return 0;
> > > +
> > > +		*offset = next_offset;
> > > +	} while (next_offset);
> > > +
> > > +	return -ENXIO;
> > > +}

There's a generalization of capability search in Hans Zhang's series, 
can it be used here too?


-- 
 i.


