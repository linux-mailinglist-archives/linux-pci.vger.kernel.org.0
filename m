Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE778C42F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjH2MXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjH2MWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:22:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D95CC1
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 05:22:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a41035828so3033056b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693311739; x=1693916539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OBjXKEw8ZCkjThY0KAx2ZAd8/PspVf1JJh0PnEyXKhU=;
        b=RcEXRcmvfwvZQwiSisvb0ipzGIh7eNRvFMhim/KixmdM95qPZOlRAcj+Sb/+YLbOhY
         K6BWsY+ca4tPQQeK0U4maQyPCT/UstAtoP3AxayOz3taD0p2QmjzlqpBB8EXXwBvfUYE
         9j6AqsgEfwqBgIEQSqX7WkUy+OsMFMHeMxJsERr1AnuoGs6ImP7m3nkm5vOR2irTWulO
         lo6o/VUiwRY0zYTaRenBKgXglu2YUhmUCINxcqBm7cjf6FcafgTw0lfUg5LE1pZGonKY
         jchNOdMQChN+BA1ecO8PHktGB4qjS4n3Tc51FpczgLVloFnAG1E6soEguAbMsqpJo3Kq
         GYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311739; x=1693916539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBjXKEw8ZCkjThY0KAx2ZAd8/PspVf1JJh0PnEyXKhU=;
        b=iNwJXCcA4bBD0Ylso3SFEJ5dReontHqLnIFkiGhopAiwi1FaF8Wfy7xLzJEexW/GNt
         hZNCOtSyFeWIGMsmLpH+LetboeO2YPL0GilUMON6zcDNaeHbTXk/ir/LBlba3Tu/e83k
         ALBOAa+cMtXOU8NHl2o/7X2CWeM+oaFmqqBcapKOaMj9a1LORyWjlFORvsMk/JSGIXMW
         dELEzBKf7YJwbhAdG7bxacUG43gLOK/EFi3xHSXS/WymPeMw1I3JcEA6Oxg/Jx4LUiqF
         PtMiFNOGV4Sq+21AOehwjjhIqOttqnm5f5VyBDqzttri8hCs3p5G7vwTFp7ZK7iiR3BE
         nnCQ==
X-Gm-Message-State: AOJu0Yy4m3KG9ANUg2bIdXla/Gng30y7ZNNm8FBnn8JL0ylEPYQdGQYH
        5039s0y4kqI/u7Ei1rKnOWyC
X-Google-Smtp-Source: AGHT+IGvOBWS9N/ndDeqSvkTcv/uVcBO1svpz3Z/RBN0GM87K4zmpRj8jRCJanLOtSVl2WeDsprpSQ==
X-Received: by 2002:a05:6a00:1702:b0:68a:3458:8e25 with SMTP id h2-20020a056a00170200b0068a34588e25mr24303886pfc.29.1693311739381;
        Tue, 29 Aug 2023 05:22:19 -0700 (PDT)
Received: from thinkpad ([117.217.187.248])
        by smtp.gmail.com with ESMTPSA id f12-20020aa782cc000000b0064f76992905sm8242844pfn.202.2023.08.29.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:22:19 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:52:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Message-ID: <20230829122210.GA33903@thinkpad>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
 <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
 <73700e92-2308-3fe0-51b1-c2373be2893e@linaro.org>
 <a0fc7f8b-dfb1-f5f8-40f2-43a4f13944ae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0fc7f8b-dfb1-f5f8-40f2-43a4f13944ae@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 29, 2023 at 05:40:10PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 8/29/2023 5:26 PM, Krzysztof Kozlowski wrote:
> > On 29/08/2023 13:41, Krishna Chaitanya Chundru wrote:
> > > On 7/28/2023 8:26 AM, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
> > > > > Add basic support for managing "pcie-mem" interconnect path by setting
> > > > > a low constraint before enabling clocks and updating it after the link
> > > > > is up based on link speed and width the device got enumerated.
> > > > > 
> > > > Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
> > > > 
> > > > - Mani
> > > A Gentle ping
> > > 
> > Whom do you ping and why me? If you choose not to use
> > scripts/get_maintainers.pl, it's your right, but then you might get
> > maintainers wrong and no surprise patches got not accepted...
> > 
> > Plus, it's merge window, so why pinging now?
> > 
> > Best regards,
> > Krzysztof
> 
> Krzyszto,
> 
> The series is already reviewed and there are some patches which is reviewed
> by you also.
> 
> I am using this command to send patches it looks like this script is
> fetching based upon the source file where there was change due to that only
> I was seeing the problem of all patches are not going to all the
> maintainers.
> 
>  --cc-cmd=scripts/get_maintainer.pl ./patch-series
> 
> I was trying to install b4 and make sure to send all patches to all the
> maintainers next time on wards.
> 
> we pinged it now so that as this is already reviewed and no comments on this
> series so that this can picked up.
> 

FWIW, it was me who pinged Krzysztof first. But I was referring to Krzysztof
Wilczyński, who is the PCI controller drivers maintainer. I thought you CCed all
the relevant people, but just noticed that you didn't :/ Please fix it as you
promised.

Anyway, since the merge window is now open, this series has to wait for 6.7.

- Mani

> 
> - KC

-- 
மணிவண்ணன் சதாசிவம்
