Return-Path: <linux-pci+bounces-27977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2CABBF27
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8637A695F
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC15278E75;
	Mon, 19 May 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdLivsjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637426A1B1;
	Mon, 19 May 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661418; cv=none; b=kM5+gXwEK8AiRcZ7Cyn0MxR3L0o9bDUVaGD1fdSLa7A3h/N01+V+27of3gcbKJqVJnWf7mTHSASiNAfjQAQ3Bg3J/mUg7wMEX6RIjt0dUE6fys4e4r0+xTxNuxn4+zMUj0XiP6fiqpHaUcpWaFysax8kEKmnZ4rPuHwhJdDMyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661418; c=relaxed/simple;
	bh=jn8+LqZ4HK4vBVVQqZdDv+ihoDP6BFDKfhN7yPeNEac=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fnx+5VP6WRDUxtm80UP4+c9pXb1iJZIWozHOI+m8pWThdkP8oq8UvKXdsKag0dPepQM99Wto+MdkLmi5A19qqycEzT7wn/wlGe+oRD6zlXVWgyZnV4oEDmc637JCaVnCyYLxsFMhR4w6mYu3yTMRrmAJJPoUZYr33DdqhGTkXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdLivsjc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747661417; x=1779197417;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=jn8+LqZ4HK4vBVVQqZdDv+ihoDP6BFDKfhN7yPeNEac=;
  b=bdLivsjcZIbXFb12rA5qTFfC8ULrfiwkmI5UbXK4Hm0Ex8RaWy3e5hSd
   bZlroHQ0RRQt9Ie4uEykAiYCkUWi0TpbGMeXspnsnUaGr2SzaTINC1fPm
   NAE+5ydaaBcithnFqD6fbYzIrW90LBpKyopyc6kJCn6w045/ApkXynNL5
   qsU+wVHqR+wGTTyMBnMtT7z6WUw7x5oDlbmBqdSGxLrASmr7E0uxmFekk
   BYKaG04/fWM/PtdJRujup1shvWTsaVO2Gcwn4UHYn+qMFt4ZRWqXXyqRR
   HizutpeNoSr7vOvO/ZMuUESa2hFvQv0kV26MZ8T3ysraFlUZU6JgeWktp
   Q==;
X-CSE-ConnectionGUID: ckc7lG4oTIeIhwpZrqaLhA==
X-CSE-MsgGUID: Npimgi65Sayn0+uB0p36EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49625776"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49625776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:30:16 -0700
X-CSE-ConnectionGUID: /UHagtsZQ2C0NZ93j31Igw==
X-CSE-MsgGUID: ZOmbe/ZFRBOhjbuGEFihvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="162659044"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:30:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 16:30:06 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/11] PCI: Export pci_set_target_speed()
In-Reply-To: <20250519-mhi_bw_up-v3-9-3acd4a17bbb5@oss.qualcomm.com>
Message-ID: <bfba6d6a-1880-a824-6418-f0f6ef6ff6f4@linux.intel.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com> <20250519-mhi_bw_up-v3-9-3acd4a17bbb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2092066973-1747661290=:928"
Content-ID: <ff8a6aeb-140a-fed4-c46c-3edcece60150@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2092066973-1747661290=:928
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <fef147ed-603d-e261-927f-91ab601d3a5f@linux.intel.com>

On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:

> Export pci_set_target_speed() so that other kernel drivers can use it
> to change the PCIe data rate.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/pci/pcie/bwctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 3525bc0cd10f1dd7794abbe84ccb10e2c53a10af..02c544c6186b8c6b87730d1c9=
24f07858571d2ae 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -214,6 +214,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum =
pci_bus_speed speed_req,
> =20
>  =09return ret;
>  }
> +EXPORT_SYMBOL_GPL(pcie_set_target_speed);

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.
--8323328-2092066973-1747661290=:928--

