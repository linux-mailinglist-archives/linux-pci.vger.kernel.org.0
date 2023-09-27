Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0F7B04E5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjI0NFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjI0NFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 09:05:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31498121
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 06:04:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so1476515066b.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695819897; x=1696424697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pyRPFM/sI4rOWP+tRGMK/egiWElrb+QbrVYo7Uy96U=;
        b=K5zwiUkznYW0Dkup4+sMUjtwyjdkWBlFOGt9mxLy1bexbUEDWHG79+I41thZL6wL+E
         k/VRLN6LhHBddV4h+8bDNaE/f2h2e0ho16whPt2Rad/H+t02vmDdRIPl35SdpxtF+QIU
         FHbZC2pGUzI7xD8jj2Qej05ON7/MSV47mzooKFmLwTojbs0gkky9UMkMhMmpALwgdryo
         VZE9jagFiqXDy/hM+oUmQNLMhrA2meSH02mmxY4CCNRXngNfFPK9GrGcPPJYpvhfyjpU
         tHpMB/sal8MNRHEDdK9nXk/QMmW5h/9k4V8eJdPNrktzAqC9rXvU8Z1rM23XpCOUSXYw
         KJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819897; x=1696424697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pyRPFM/sI4rOWP+tRGMK/egiWElrb+QbrVYo7Uy96U=;
        b=Y6ixysy7s+ogF/Wsko1/maC4GpxfE/wboVyjpc7jyxdObspxNRGcnQiDDzJFFm0wtQ
         9+hQ8AtrMHfNR3pAV8leWOFGdc/WhTioaBbmelWONWns0wHhd+km98DCSq9qmmR+MX6+
         xdGygEKv37iWYWP9lH3t7MdVIsuVmwYfF63JJVHf4ZVnkh3SmiyKuFrllc/rtBjFPu1B
         h2rfBEyw2tDrM6BNZ+F0ByHHRK/UcbI1EL4BaTyj2Ojz69PpB4l5ZGEacaXHv7hU/z3+
         m7mXvhIepFka1rwu9jWCAyQHaRg+50/L3KOUjn3b3DWgH6Fv4gdAZaBOR8KSKP5yIKpj
         kTzQ==
X-Gm-Message-State: AOJu0YyA5tL78Gg+/2oCV7+kE9LfWfehsgSlZGbkCZLiEDRcqixwQEDZ
        8Rw1A/gxbz/Z4B5v0GOlKSAD
X-Google-Smtp-Source: AGHT+IFqyNEC2JG004BLvFeQ883vvmzZmbXiMQhzHmmFHvL4w/Lf027wOmvQvTqgLndBUE84MjF0KA==
X-Received: by 2002:a17:906:7694:b0:9b2:82d2:a2db with SMTP id o20-20020a170906769400b009b282d2a2dbmr1434401ejm.28.1695819897021;
        Wed, 27 Sep 2023 06:04:57 -0700 (PDT)
Received: from thinkpad ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id ep14-20020a1709069b4e00b009a168ab6ee2sm8703004ejc.164.2023.09.27.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:04:56 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:04:55 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH] PCI: qcom: Add interconnect bandwidth for PCIe Gen4
Message-ID: <20230927130455.GB19623@thinkpad>
References: <20230924160713.217086-1-manivannan.sadhasivam@linaro.org>
 <20230926210823.GA427669@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926210823.GA427669@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 26, 2023 at 04:08:23PM -0500, Bjorn Helgaas wrote:
> On Sun, Sep 24, 2023 at 06:07:13PM +0200, Manivannan Sadhasivam wrote:
> > PCIe Gen4 supports the interconnect bandwidth of 1969 MBps. So let's add
> > the bandwidth support in the driver. Otherwise, the default bandwidth of
> > 985 MBps will be used.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 297442c969b6..6853123f92c1 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1384,11 +1384,14 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> >  	case 2:
> >  		bw = MBps_to_icc(500);
> >  		break;
> > +	case 3:
> > +		bw = MBps_to_icc(985);
> > +		break;
> >  	default:
> >  		WARN_ON_ONCE(1);
> >  		fallthrough;
> > -	case 3:
> > -		bw = MBps_to_icc(985);
> > +	case 4:
> > +		bw = MBps_to_icc(1969);
> 
> The bare numbers here are sort of weird.  I assume they correspond to
> the Supported Link Speeds Vector in Link Cap 2, and I expected them to
> correspond somehow to PCIE_SPEED2MBS_ENC(), which computes the usable
> PCIe bandwidth per lane.  I see the ratios between 250, 500, 986, 1969
> *do* match up with the ratios of PCIE_SPEED2MBS_ENC() values, but I
> don't know the PCIE_SPEED2MBS_ENC() values aren't used:
> 
>             SLS Vector                         PCIE_SPEED2MBS_ENC()
>   CLS 1:  bit 0  2.5 GT/s   MBps_to_icc(250)      2000 Mbps
>   CLS 2:  bit 1  5.0 GT/s   MBps_to_icc(500)      4000 Mbps
>   CLS 3:  bit 2  8.0 GT/s   MBps_to_icc(985)      7879 Mbps
>   CLS 4:  bit 3 16.0 GT/s   MBps_to_icc(1969)    15753 Mbps
> 
> This is just my curiosity, probably no change is needed, or at most a
> short comment.
> 

You are right. I'm not aware of this macro before and yes, I can make use of it.

> I do notice that pcie-qcom-ep.c uses #defines like PCIE_GEN1_BW_MBPS,
> and it seems like both could use the same style.
> 
> Also agree with Konrad that the ordering ends up looking unusual;
> maybe would be more readable if the default case repeated the speed
> you want instead of using the fallthrough.
> 

Yes, that would be more readable.

- Mani

> >  		break;
> >  	}

-- 
மணிவண்ணன் சதாசிவம்
