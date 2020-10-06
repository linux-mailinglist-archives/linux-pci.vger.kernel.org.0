Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869C8284A31
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJFKNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgJFKNJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 06:13:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D1C061755
        for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2020 03:13:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so8741468pfd.5
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2020 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uw1N7UWF96sWJaY9vam9SXfMcttrbkshU5+DLAI3Dg=;
        b=PzvKOpxNm1skQxTigFsNiauFBTeC+iAJr6SDZhRsu8xn7EHf2IWIhQP7lU0DRtm4Qz
         A+tMDBaQ6jdcxOcNTa3KdZX/IzjEC3SqCLn/dH8gc+h0r/FQXoshQCYhdJTkHXhsWocy
         dRDTWXOcr3/hZNwndTFWpGIQzHJp+Ff3ztqBjURWte/nOxA3fmFo57nXhLnyFrSk3WGD
         6hqmPiQXTbJxYkwEuzw8ZrmxkODGf41MPoXPrAZd+SpH+aqfF5fnx2c7AXnrh1nFPGaU
         KQJrbJ3d8TWqlK1bClPtUHLnnoId0NAbiaIYb71HgM7lxMlGeVot55ibM+apW7D6FVjR
         4QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uw1N7UWF96sWJaY9vam9SXfMcttrbkshU5+DLAI3Dg=;
        b=IxpUjGb3YKDen8PpRaIgx2VU3DCYGe2HhEZJv5ruo8v2hZDIqqCeQnnXBUn0tmEaUn
         2DRTmLwilbW+7JzmkopyMYfUOcs2HIp2MkfYnUco0WrvHzZshnwgCHWpuJQr+Ob39nWN
         Vh+lL3rmK5CBYq0a7p3THE282Xf76uz6uTAnalPRB5voGUpQnAL43cSSBf5+chaYI7TU
         qzOwNRplos5sjQQQqRhsFJ2qEd6DJcWiUT5f03/uGfn0kynojwEj+Swekjmn1RLyIIPV
         6GE5aGzZSdAYn/l9RcFiaSXGBvJMZARu4NhwMM4WM0uGs5Ha844bPTy5VX90McunjwN2
         6H9A==
X-Gm-Message-State: AOAM532xE8zAyDGvaOFUPgoVy8oeBXrtXSvZgC/Uo09wM2fFnGkI2cXN
        yOc9FRcQvv5tvymM37/bGHMb
X-Google-Smtp-Source: ABdhPJyFgKf3woKusGWc1qj6JOvJKKyzlPudg/T+w4L8YsNTdJnOvuvZRY0xPcgFu4nA1LIsvLM9Tg==
X-Received: by 2002:a63:1647:: with SMTP id 7mr3365364pgw.446.1601979187779;
        Tue, 06 Oct 2020 03:13:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e9d:8f58:948:749c:4eeb:26a])
        by smtp.gmail.com with ESMTPSA id ep4sm2293143pjb.39.2020.10.06.03.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 03:13:07 -0700 (PDT)
Date:   Tue, 6 Oct 2020 15:42:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Robin Murphy <robin.murphy@arm.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org
Subject: Re: [PATCH v2 5/5] PCI: qcom: Add support for configuring BDF to SID
 mapping for SM8250
Message-ID: <20201006101259.GA31305@Mani-XPS-13-9360>
References: <20200930150925.31921-1-manivannan.sadhasivam@linaro.org>
 <20200930150925.31921-6-manivannan.sadhasivam@linaro.org>
 <507b3d50-6792-60b7-1ccd-f7b3031c20ac@mm-sol.com>
 <20201001055736.GB3203@Mani-XPS-13-9360>
 <e63b3ed4-d822-45dc-de60-23385fb45468@mm-sol.com>
 <1dd23bad-3bea-fb55-e1fb-05ea3497dfd3@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd23bad-3bea-fb55-e1fb-05ea3497dfd3@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Oct 06, 2020 at 10:15:08AM +0200, Marc Gonzalez wrote:
> On 01/10/2020 12:57, Stanimir Varbanov wrote:
> 
> > On 10/1/20 8:57 AM, Manivannan Sadhasivam wrote:
> >
> >> On Thu, Oct 01, 2020 at 12:46:46AM +0300, Stanimir Varbanov wrote:
> >>

[...]

> >>> iommu-map is a standard DT property why we have to parse it manually?
> >>>
> >>
> >> So right now we don't have a way to pass this information from DT. And there
> >> is no IOMMU API to parse the fields also. We need to extract this information
> >> to program the hash tables (BDF, SID) as the mapping between BDF and SID is not
> >> 1:1 in SM8250.
> > 
> > We used iommu-map for msm8998 see this commit:
> > 
> > b84dfd175c09888751f501e471fdca346f582e06
> > ("arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes")
> > 
> > I also Cc-ed Marc if he knows something more.
> 
> My memory is hazy.
> 
> I remember an odd quirk in the downstream kernel:
> 
> [v1,1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
> http://patchwork.ozlabs.org/project/linux-pci/patch/958ae127-3aa2-6824-c875-e3012644ed3d@free.fr/
> 
> Manivannan, are you trying to deal with PCIE20_PARF_BDF_TRANSLATE_N
> or some equivalent register?
> 

I'm dealing with PCIE20_PARF_BDF_TO_SID_TABLE_N but I'm not sure how it
relates to PCIE20_PARF_BDF_TRANSLATE_N.

> +Robin, he's the one who helped me figure this stuff out (iommu-map).
> It was in reply to patch 2:
> http://patchwork.ozlabs.org/project/linux-pci/patch/82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr/
> 
> In the end, I dropped patch 1 because... everything seemed to work
> without it (?!) (Makes one wonder what it actually does. But qcom
> refused to provide any register documentation, which is idiotic
> because this is DW IP, and they are open-source friendly, IIUC.)
> 

Without this patch, PCIe will work on SM8250 but during successive reboots
I started seeing issues which gets fixed by this patch.

Thanks,
Mani

> Regards.
