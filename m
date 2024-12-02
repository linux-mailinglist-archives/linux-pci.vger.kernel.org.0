Return-Path: <linux-pci+bounces-17522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FD9E02CA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0503216493D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CB209680;
	Mon,  2 Dec 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKyK0hww"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92320968A
	for <linux-pci@vger.kernel.org>; Mon,  2 Dec 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144344; cv=none; b=bTyWd76TMYuHLrufQyaFIxgzb1BT9Vn83NWX4gCBBD2L4kAlTcNOqbCb8+OiFibtBevB7s3mv+qGf/ISvXwqx1B2mGkImVXUp+M6XgNU2YbYKRxRd4WkN1UyCPWzvqtnFsGdRU9KSZRog9yHTFViUHVqCZTvMQmVbD7Wp+8Xors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144344; c=relaxed/simple;
	bh=84F50RDLSxwvaiL/Ut5/RJLgaAhNDidEJM6Aelx6NOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoGsfGzqlnznxaJKpVSY/nVzYmF+IBarEVf58nrFrjIMYpJTE4SP1tZGcAFdQkjfIgEthCkc5UpM5D0H90ybcPCKcIAvMZid2q/P0qpblL+hcfWTNjTRLzfP1clekI1f4w+GEMTZeBr+1X5AyFPzb7Mbw75udGesBE+Ix03LYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKyK0hww; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215853ed047so12544575ad.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Dec 2024 04:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733144341; x=1733749141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6CCvtQVXQrLvAOM+4VRXFfpLmG3wrstufKddBuVhAJQ=;
        b=DKyK0hwwQNncIv2W+kktnDsm+uwGi61NVsPGfzI7wRLdfQ3Ka06Bz5srnrjKpCnLN5
         2vBDGzgB4LEll0nb7jnCWNlmaUxAEPbSBgTDoGA7A316P+8f9B3GuYx+WfJ2oH8bi51z
         JUdDipAhSc/o+zOrFYarR7G3a/EkeY3zFAyIG9pHwDE2SoefVa107fA1iheDoY6FOGM6
         p6ek52PQAGAnJySRRmfaBdQQQktJV4gtRdlcIUmqY6JG5BS1+1B/DwtoXBJtsTiSJW6V
         HDDYwwwFxkTVUFck4r8P4zxAW5DJDOqJ/xH6D/g33C0zG8Q4VXCOv0iRf8Gy7G3Folys
         yJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144341; x=1733749141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CCvtQVXQrLvAOM+4VRXFfpLmG3wrstufKddBuVhAJQ=;
        b=mVCICjRjB213pBdPudmcDPTBQluwr9f9wrPHclaApLUe86BY2n6j2seIhbBBDTWIBJ
         c4CuHu/bCoRGcdm900OJhpVD8VY0rVix016NooxP07ke5PRT2XyVq4oRngf43zNIif1S
         L3xZHIx7MHBqE3O0dF+LH7AJTyTX3Mzl/cg/oeMw8jHlLS3zRdYL6e4BxWpbALvWHutQ
         a2c3bM6W+hWDcg7X9w4LB7iLvGAAWzyHZdTnGakI2boQbcWHJ2cfvtKVw6XRRp4P3mvf
         ntwbuz1DecXffHJImQRQXFe3Pvz4UFUg9Mm0cfcM/QtAjuWJicdYrt84OPgHLTDcPtbL
         JMeA==
X-Forwarded-Encrypted: i=1; AJvYcCXfe0pPGNCWUBSLw6s2UxnytyRCB0zbuelc6S2ujJrrqbf2vAB4NjPWB9/Kemfs8JNiEayxnSmlKhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqVvtNXrXThytvO1BJkBhG+OzxiYhUV17trko6NuLMMKWVVe1
	bC/EvuZTB3M6KcBBwINEyoc5xxS15S1U/zUhfNEz9Wm8MC5fZGWDiYop6YLcGA==
X-Gm-Gg: ASbGncvLO4sXz6jEQS2PDuzz8FSH4z5bNvJ8/gHV9s39QbWXLyoosb0vbFaMInlACsj
	or7KeONzx0Tb/iahTbbarTfBFXOIxAmoUtvLnlGEyh1uXVCnz0KvYvawpRp5a7ztz0csA/VgoaF
	yxaEaD0y6lMoLZt5tWHNsXEPI58sy7CygDivWXcVz3uU0SELRpNuRXNxsCJUFHNIuNGyXL2OlMq
	gBMup80oN4vTJNYeUNMuFsD80YFWNSPe4kfzAhvJOkrKhK8z8pKDHueU0ZKtg==
X-Google-Smtp-Source: AGHT+IGb8lymZBMlKvEv3D6XKmMObg2pfnQBEi8/oeAOIIzR3QMSbRXUP7cxeVvRLLDRh2EmtlIy1g==
X-Received: by 2002:a17:902:e5c5:b0:215:6cb2:787e with SMTP id d9443c01a7336-2156cb27b96mr105778365ad.9.1733144341390;
        Mon, 02 Dec 2024 04:59:01 -0800 (PST)
Received: from thinkpad ([120.60.140.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156c99a827sm34935945ad.166.2024.12.02.04.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:59:00 -0800 (PST)
Date: Mon, 2 Dec 2024 18:28:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and
 BAR1/BAR3 as RESERVED
Message-ID: <20241202125845.rp4vc7ape52v4bwd@thinkpad>
References: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
 <20241129195537.GA2770926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241129195537.GA2770926@bhelgaas>

On Fri, Nov 29, 2024 at 01:55:37PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 29, 2024 at 02:54:12PM +0530, Manivannan Sadhasivam wrote:
> > On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
> > cannot change the type. So mark the those BARs as 64bit BARs and also mark
> > the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
> > use them.
> 
> "Default" implies an initial setting that can be changed, but you say
> "by default" and also "software cannot change the type."  Can they be
> anything *other* than 64-bit BARs?
> 
> If they're hardwired to be 64-bit BARs, I would just say that.
> 
> > Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
> 
> If stable maintainers need to act on this, do they need to search for
> the patch introducing only_64bit flag?  That seems onerous; is there a
> SHA1 that would make it easier?
> 

But that's not the point of having noautosel tag, AFAIK.

Documentation/process/stable-kernel-rules.rst clearly says that this tag is to
be used when we do not want the stable team to backport the commit due to a
missing dependency.

If we really want stable team to backport the change with dependencies, then the
dependencies should be mentioned using the SHAs:

From Documentation/process/stable-kernel-rules.rst:

```
* Specify any additional patch prerequisites for cherry picking::

    Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
    Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
    Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
    Cc: <stable@vger.kernel.org> # 3.3.x
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

  The tag sequence has the meaning of::

    git cherry-pick a1f84a3
    git cherry-pick 1b9508f
    git cherry-pick fd21073
    git cherry-pick <this commit>
```

Here I did not intend to backport this change with commit adding only_64bit flag
because, I'm not sure if that dependency alone would be sufficient. If someone
really cares about backporting this change, then they should figure out the
dependencies, test the functionality and then ask the stable team.

- Mani

> > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index e588fcc54589..f925c4ad4294 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
> >  	.msi_capable = true,
> >  	.msix_capable = false,
> >  	.align = SZ_4K,
> > +	.bar[BAR_0] = { .only_64bit = true, },
> > +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> > +	.bar[BAR_2] = { .only_64bit = true, },
> > +	.bar[BAR_3] = { .type = BAR_RESERVED, },
> >  };
> >  
> >  static const struct pci_epc_features *
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

