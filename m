Return-Path: <linux-pci+bounces-207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB347FB220
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 07:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E72DB20B5C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E835CA73;
	Tue, 28 Nov 2023 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oC2BWySd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF62E1
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 22:51:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb749044a2so5139618b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701154272; x=1701759072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBQiDTGElGC/iQuipJvaEvquIy+irMHsbVUaQJuQwC4=;
        b=oC2BWySdg2uYob0IRI+M8ezMLlQsG62loSyygbvzxmBG5nJmEhjukn/C79pTqfK0Tc
         lBb7noCXoB3E8Plwq0+bNt1ZZ8vyE/uEmmZfhLU71BZoY5PA88uThki8LOQ65aRXtUBK
         iJX6qk8tKWxt14y0QacEem1DFnhJPu798e36yPTRzY10wGdPs4eYS/EXuwa3JlFGukry
         /CUMHa6ZeWl/oMLaCLjiMqW35rlHRtohKSvrsfVsOy7i2aye6+Gj8mDNbjB5hko/uIV3
         XpLlpHulgLV71wGH8Y/HuFI7QuFiue8/M5X/mNFShGoCErYOallx7r1pffVRGqCIMjWl
         xuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701154272; x=1701759072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBQiDTGElGC/iQuipJvaEvquIy+irMHsbVUaQJuQwC4=;
        b=L7yU2CpYR3BB9dXMFXqP1dFJlFLoSpoUtBgpoBc16OI8Nah5saE5UldqSTuXlIlYBN
         lyC2iLKM2lqAwp36JCwpCG5FJ6tpx9QSTqu3MHTSK74EhjpwiehZsF8Sgyx4SPyFE1oP
         3KFqJDCVn71IeQ4TBl/Ec5+EDGWXWv5J4DfftQV/08BPoYRl4AiG61TMAxBEg3d1gos8
         Q4wKmN4H+A1eehT4tVFXFR+dEFWam71nJ+R+gfOnv92WnE4YLOPxZMQy05nrdE2K9Heh
         wAfM8izvxiH+YtNVX+5vtqssKrCwvO9rZmiKwW8b1axIyHkQLXerpyJJVd8u9w3/TNx1
         Bleg==
X-Gm-Message-State: AOJu0Yy7GkXkEutt8/hVbEwdrv0Tp0uifuF4JuMYOHz2L0RgRozmf2wS
	Z//t/jCW2dfH6lme7iIwdNb2kDw90IYIN9D4/g==
X-Google-Smtp-Source: AGHT+IEnvI4ydDHNEQqF42I/aL26b1A2O/ZB/+msey5Q3lR6xnG7ljDsBqZEJiYNuUCIne2HrUUoPA==
X-Received: by 2002:a05:6a00:a18:b0:6cb:8a8a:4bb6 with SMTP id p24-20020a056a000a1800b006cb8a8a4bb6mr16162259pfh.11.1701154272009;
        Mon, 27 Nov 2023 22:51:12 -0800 (PST)
Received: from thinkpad ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b00692cb1224casm8293437pfa.183.2023.11.27.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:51:11 -0800 (PST)
Date: Tue, 28 Nov 2023 12:21:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: intel-gfx@lists.freedesktop.org, helen.koike@collabora.com,
	daniels@collabora.com, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix compile error
Message-ID: <20231128065104.GK3088@thinkpad>
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
 <20231128051456.GA3088@thinkpad>
 <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50a9f061-e1d3-6aca-b528-56dbb6c729d9@collabora.com>

On Tue, Nov 28, 2023 at 11:44:26AM +0530, Vignesh Raman wrote:
> Hi Mani,
> 
> On 28/11/23 10:44, Manivannan Sadhasivam wrote:
> > On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
> > > Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
> > > to acquire bus lock") has added an argument to acquire bus lock
> > > in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
> > > without this argument, resulting in below build error.
> > > 
> > 
> > Where do you see this error? That patch is not even merged. Looks like you are
> > sending the patch against some downstream tree.
> 
> I got this error with drm-tip - git://anongit.freedesktop.org/drm-tip
> 
> This commit is merged in drm-intel/topic/core-for-CI -
> https://cgit.freedesktop.org/drm-intel/log/?h=topic/core-for-CI
> 

Okay. Since this patch is just for CI, please do not CC linux-pci as it causes
confusion.

- Mani

> Regards,
> Vignesh

-- 
மணிவண்ணன் சதாசிவம்

