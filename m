Return-Path: <linux-pci+bounces-42551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC5C9E4BE
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 09:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A82434329F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705DE2BDC33;
	Wed,  3 Dec 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtx2dSdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E702BD58C
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751582; cv=none; b=kIEdaUnACYxUiKbdsPTf9Ki34MSEjRiio2LNk4Mbw51Dv6gW4l/ESVA89cMqjaoaUxz41HqP0IS4k3mwIwgGlxv7HEEWkmRQmKJpFQq0jgh1PWq1SZI8203T399hSf7xucydS/IJ1MN4qvFYh5b1zJjNVmAagUkTBUgYhosCTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751582; c=relaxed/simple;
	bh=+JL27+FiggSb0VhPoQSBWCZ+OGPNrTMX7uEbUWMGIl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arvoxlpxox1t4BX53LH6yXx0gr22fFZO5MGJ5LAcS3q3B8XndImoFjBUTzN6FiJrp9b5Y3CXQOsKSDU/74MbX+UmYfpqBdFFx5awLIRPPYR++arQiHOc7svt0PE4iX9WweADnkJPqlZVHlOEEn3QL+ylsIgUceAaufpjebGLnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtx2dSdI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso4980999a12.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764751580; x=1765356380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubn96hZCY6OuLzYZcN1v+Qbk5qXz2YwsDlmONqQGhII=;
        b=rtx2dSdIx9ORcQx3PE2MBwGRdoS96XasI2J3SyNEpbW2FLo/0Yqe6MjsrwvkunyR9y
         xe8OyGveHjmOXmclWqE4M1NEqSY4PBCwaYvS82SJI0JwHf8xwKjm6zy5NEqm5zJlob2K
         5fwbzcvXmQskGSR3+n52CvQk4rA4tJDSIX6BDCOG+WLxOnX5nFQcsUJixjjgNtwXH7S4
         43fWR8KJrmp9ATdwAdoKRMSSZ0eV22PY/a/+naVWw46N4pxxd/8GXbnkfg5Bb7b6uo+1
         Cggklr4Al9J0+7+A17grT73iLbw/PCj7XT6My9ppu9QkZaQd5kja8caM27fRoCnVjECY
         IfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764751580; x=1765356380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubn96hZCY6OuLzYZcN1v+Qbk5qXz2YwsDlmONqQGhII=;
        b=J7RNIyqNwtcLygbZAcMUnAs8bUSR7CCPp9QLf4iX3rD1DHKQYinvee7grF/XZJdhoo
         gMqNWmzvtl3dX92mJyl7v7wN93VjHPs08K3ScfPjs320zUdQYC4omeP/wYLyk1Odwu0V
         HTfXac6l2n7okk6JSnCli+ls7kFHjrDMYhk8JUHNr5Cx3VNHowreGTvwW/K+AHOuPc+1
         BfEdZCI186qhdWOR6lqKXu0le9H+qE84zyCF6NN7NuwdAI6ZaOedyQHfe8zQqHbjRMf/
         drc9p4f6L71acp4PwtwINEo/pzcz5HjZqAgHvoMVYsBDBzrnIDjlSr2r0V43U722AptQ
         ebdA==
X-Forwarded-Encrypted: i=1; AJvYcCUjiyRXb2NOLgECCB09kxHJNGN4xBLMGUv5PQEj01xCOBsFj6hh2wTM0hvPtq0OxVbTD9IauiOdcr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIL9xImY5gC2MgzIj940LPZG61St7HXRTwLVRWTR0qf+kRRldw
	YHiHE1H6kzOSzFosfH+IksU8W6Lo9pFBMF80ZsmKnuMlI+WqfgmitjXIw+m9xkUvbety4VVyqhW
	IJBAnHKevMIdDmpsI/2umOO04VVcGCfedglO/Mw50Bg==
X-Gm-Gg: ASbGncuqr4DhiYKLmjbzAvoZUxk5OXfM/c8A7iKDqaPwGzuMD+NILj3CC8ade4Lav+J
	MeL0NSuKxeM578qioKyWeueq5FI3N3+pnK3G1H71DL9b6TB34eiNKEkXtIHo324lIenvH0nDLzp
	WRIaWwznhwicOtNC8yoGfpYtgTkIdfe9YX9grw1udUOhZYOoC3i49y9ye2bdCQnSRgHA/iDR6nr
	EIZBTE7k3q1R8NWKOXNE5I4DRF7w60Y7NX9eQE4BDU0CDxr+0/vmP3zqnpmULSRL21H65CdX9gg
	uE/YPuuSBZBiJxbXwbM/FYnzA4c4
X-Google-Smtp-Source: AGHT+IESfyz0WvcdLg5zso+cF/spjXjFo7mPapRZnsru8lI4xWV9asxUh3P8AuvahqHOyEhQ7GV0QrnDc6g77E/4q1Y=
X-Received: by 2002:a05:693c:2285:b0:2a7:760:2b61 with SMTP id
 5a478bee46e88-2ab92da0fe1mr1128392eec.3.1764751579599; Wed, 03 Dec 2025
 00:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Dec 2025 14:16:08 +0530
X-Gm-Features: AWmQ_blHL_iDCylpGXX4vpPrEWS5hqhh9zdpg4OOEAJju8Mpzrh8qH6Yoml_Sl8
Message-ID: <CA+G9fYsLjKov93zsZfPovVmfEus6QzaVd_QvCYtmqMn+kY+6ng@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: Fix ACS enablement for Root Ports in OF platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>, Xingang Wang <wangxingang5@huawei.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 19:53, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Hi,
>
> This series fixes the long standing issue with ACS in OF platforms. There are
> two fixes in this series, both fixing independent issues on their own, but both
> are needed to properly enable ACS on OF platforms.
>
> Issue(s) background
> ===================
>
> Back in 2021, Xingang Wang first noted a failure in attaching the HiSilicon SEC
> device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
> ACS not being enabled for the QEMU Root Port device and he proposed a patch to
> fix it [2].
>
> Once the patch got applied, people reported PCIe issues with linux-next on the
> ARM Juno Development boards, where they saw failure in enumerating the endpoint
> devices [3][4]. So soon, the patch got dropped, but the actual issue with the
> ARM Juno boards was left behind.
>
> Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
> hoping that someone in the community would fix the issue with ARM Juno boards.
> But the patch was rightly rejected, as a patch that was known to cause issues
> should not be merged to the kernel. But again, no one investigated the Juno
> issue and it was left behind again.
>
> Now it ended up in my plate and I managed to track down the issue with the help
> of Naresh who got access to the Juno boards in LKFT. The Juno issue was with the
> PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
> Completions received for the Configuration Read Request from a device connected
> to the downstream port that has not yet captured the PCIe bus number. As per the
> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
> supplied with all Type 0 Configuration Write Requests completed by the Function
> and supply these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests". So during the first Configuration Read Request issued by the
> switch downstream port during enumeration (for reading Vendor ID), Bus and
> Device numbers will be unknown to the device. So it responds to the Read Request
> with Completion having Bus and Device number as 0. The switch interprets the
> Completion as an ACS Source Validation error and drops the completion, leading
> to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
> 6.12.1.1, states that "Completions are never affected by ACS Source Validation".
> This behavior is in violation of the spec.
>
> Solution
> ========
>
> In September, I submitted a series [6] to fix both issues. For the IDT issue,
> I reused the existing quirk in the PCI core which does a dummy config write
> before issuing the first config read to the device. And for the ACS enablement
> issue, I just resubmitted the original patch from Xingang which called
> pci_request_acs() from devm_of_pci_bridge_init().
>
> But during the review of the series, several comments were received and they
> required the series to be reworked completely. Hence, in this version, I've
> incorported the comments as below:
>
> 1. For the ACS enablement issue, I've moved the pci_enable_acs() call from
> pci_acs_init() to pci_dma_configure().
>
> 2. For the IDT issue, I've cached the ACS capabilities (RO) in 'pci_dev',
> collected the broken capability for the IDT switches in the quirk and used it to
> disable the capability in the cache. This also allowed me to get rid of the
> earlier workaround for the switch.
>
> [1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> [2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> [3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> [4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> [5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> [6] https://lore.kernel.org/linux-pci/20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com
>
> Changes in v2:
>
> * Reworked the patches completely as mentioned above.
> * Rebased on top of v6.18-rc7
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>


> ---
> Manivannan Sadhasivam (4):
>       PCI: Enable ACS only after configuring IOMMU for OF platforms
>       PCI: Cache ACS capabilities
>       PCI: Disable ACS SV capability for the broken IDT switches
>       PCI: Extend the pci_disable_acs_sv quirk for one more IDT switch
>
>  drivers/pci/pci-driver.c |  8 +++++++
>  drivers/pci/pci.c        | 33 ++++++++++++--------------
>  drivers/pci/pci.h        |  2 +-
>  drivers/pci/probe.c      | 12 ----------
>  drivers/pci/quirks.c     | 62 ++++++++++++------------------------------------
>  include/linux/pci.h      |  2 ++
>  6 files changed, 41 insertions(+), 78 deletions(-)
> ---
> base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> change-id: 20251201-pci_acs-b15aa3947289
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>

