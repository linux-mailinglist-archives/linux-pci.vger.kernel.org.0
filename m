Return-Path: <linux-pci+bounces-10725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F193B268
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CDA1F21646
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086AEEAB;
	Wed, 24 Jul 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4gTwJPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFA15688D
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830218; cv=none; b=BEFPNXgw6mDVTWxroW85OrbwYY3PJGfHW7DVTWYhzVbcXf5jJZoTSYtlqHqW4OD443sFN6qpISKaKlQVi6ACb18VuFzruiW8bLxyPZtqzSIU+glv0jXuxQbpe+MhcogqBXiW+InU/mZiv1YBXG6a5QOB5wOpY189S8hT/mwgCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830218; c=relaxed/simple;
	bh=bQ66+SsmOkp4FfJAE3qwpS9H2kE3nhkswugvFsE26zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMJFLKsUibc33PO5OBOLXYLfzTsWkvJ2FdwHLGQxoU+O1W8L8i+6RMgBVtIcD8ldjU2Jom4K7j8eTmIClbgoOn4hNCVmNV9W8zT34bPge67mjNawhqfLjGMJ9XPGAJbIUa9WeTZWBE4ulMx4qU3Itql3e1qj0fa4R7ZHz6J1zY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c4gTwJPW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd90c2fc68so16660435ad.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721830215; x=1722435015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hvjqD7swXLIXWuSmMXHVgPpzmpB1cUWaSgkw1M36cKs=;
        b=c4gTwJPWymuuKecIwgPz3AuZEykTZkYGZnIoZExEOJRb6SEmey0Tii9SpHxNrLpwl3
         hsFv5OVeAtxKfox9bPplQUA8aHkgKvpsh62Q7VV3/CNtViuatztdhWJfGjGHQ/yHeFJo
         0HX6OosEbTbSPeQVwz7UUhqPjPfhaFL7uWf2s4mGRRuz1mgBB9H4oPNP46uH7dj2+uhT
         ronJCbNNK+gvFoKXTKSAco5SnBqHuKbiTn8kMZXfxr08jk2braE0mxrx4Z385VU5CfrN
         rbqB2SNqiJn/qik8yOitk0w/1p+Y4kuPjxoHvcm/4ZDzTM6LueFlmod9FDPFtzcGlvxC
         ZyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830215; x=1722435015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvjqD7swXLIXWuSmMXHVgPpzmpB1cUWaSgkw1M36cKs=;
        b=N591Xzv7+pUSJwfMaJB+J3MnOx4pC5SGsgHzJnIxsXfknYNxdUOHOWFefrkvZlh3wM
         JzK3J3HCOOHimQx4SQhXKN36aYSA2EXIJOLAueDFkfOBIs+GT3s6oWLC/p3Dk8GotDCC
         QoH040okBmyO7eni1zGGgKhAJTDfxqnt+3kZdTLnKuOYldtUBXLRATlDhNqHtQJJDcqW
         5qCrsEgHfZ4ITS9qJ6eEJI/toTuirntwQ+xo6hMfx70jED4ZAbsM7uxDsPAvqLLPWetx
         eEl2yWj4odAZpdMieb0sKReml+uQ2pTsfkojEPEctcZapqQu5WThkO1OIUhDvSZB7xrE
         uTQg==
X-Forwarded-Encrypted: i=1; AJvYcCWL90xsBQ8d2oQIX42eBy1/LbbHCPdhRLkSrHSi0WzEq76vcVOZkfVteJb7aAl0Hh8sPnw/XYcgln8I0ayEd0Cs5ZWhAAKJqJaa
X-Gm-Message-State: AOJu0Yx8OZUUcXByFHQBda+VT7oyw7TXItZBCAl2DvOddYWMXRXbJtNv
	0GTXYe+5iMUsgitphGF169hkxSEYgRRVBqG6XGP2t6ZQg41yULJSSfXWotqLtw==
X-Google-Smtp-Source: AGHT+IEoUP6NUSEW4jgaZi/xERIdHEdgC0MhnYneK7cZJ4vc3A7QarO7M6AJ9jWlyTlwGFhNHH9trQ==
X-Received: by 2002:a17:902:8549:b0:1fd:6d6d:68e4 with SMTP id d9443c01a7336-1fdd559aef0mr21243895ad.57.1721830215494;
        Wed, 24 Jul 2024 07:10:15 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31d2bbsm94453065ad.132.2024.07.24.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:10:15 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:40:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 2/2] PCI: qcom: Avoid DBI and ATU register space
 mirror to BAR/MMIO region
Message-ID: <20240724141011.GF3349@thinkpad>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-3-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724022719.2868490-3-quic_pyarlaga@quicinc.com>

Subject:

PCI: qcom: Disable mirroring of DBI and iATU register space in BAR/MMIO region

On Tue, Jul 23, 2024 at 07:27:19PM -0700, Prudhvi Yarlagadda wrote:
> PARF hardware block which is a wrapper on top of DWC PCIe controller
> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> register to get the size of the memory block to be mirrored and uses
> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> address of DBI and ATU space inside the memory block that is being
> mirrored.
> 
> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> boundary is used for BAR region then there could be an overlap of DBI and
> ATU address space that is getting mirrored and the BAR region. This
> results in DBI and ATU address space contents getting updated when a PCIe
> function driver tries updating the BAR/MMIO memory region. Reference
> memory map of the PCIe memory region with DBI and ATU address space
> overlapping BAR region is as below.
> 
>                         |---------------|
>                         |               |
>                         |               |
>         ------- --------|---------------|
>            |       |    |---------------|
>            |       |    |       DBI     |
>            |       |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |       |    |               |
>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>            |    BAR/MMIO|---------------|
>            |    Region  |       ATU     |
>            |       |    |---------------|---->ATU_BASE_ADDR
>            |       |    |               |
>         PCIe       |    |---------------|
>         Memory     |    |       DBI     |
>         Region     |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |    --------|               |
>            |            |               |---->SLV_ADDR_SPACE_SIZE
>            |            |---------------|
>            |            |       ATU     |
>            |            |---------------|---->ATU_BASE_ADDR
>            |            |               |
>            |            |---------------|
>            |            |       DBI     |
>            |            |---------------|---->DBI_BASE_ADDR
>            |            |               |
>            |            |               |
>         ----------------|---------------|
>                         |               |
>                         |               |
>                         |               |
>                         |---------------|
> 
> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 
> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> U32_MAX (all 0xFF's) to PARF_SLV_ADDR_SPACE_SIZE register to avoid
> mirroring DBI and ATU to BAR/MMIO region. Write the physical base address
> of DBI and ATU register blocks to PARF_DBI_BASE_ADDR (default 0x0) and
> PARF_ATU_BASE_ADDR (default 0x1000) respectively to make sure DBI and ATU
> blocks are at expected memory locations.
> 
> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
> and PARF_ATU_BASE_ADDR are applicable for platforms that use PARF

There is no 'PARF Qcom IP', just 'Qcom IP'. Here and below.

> Qcom IP rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for PARF Qcom IP rev 2.3.3.
> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for PARF
> Qcom IP rev 1.0.0, 2.3.2 and 2.4.0. Updating the init()/post_init()

Use imperative tone in commit message. s/Updating/Update

> functions of the respective PARF versions to program applicable
> PARF_DBI_BASE_ADDR, PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR
> register offsets. And remove the unused SLV_ADDR_SPACE_SZ macro.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 62 +++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..6976efb8e2f0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -45,6 +45,7 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> +#define PARF_SLV_ADDR_SPACE_SIZE		0x16C

Use lowercase for hex.

Rest LGTM! With above mentioned changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

