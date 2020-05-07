Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5392A1C9B2F
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGTem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGTem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:34:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D05C05BD43;
        Thu,  7 May 2020 12:34:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so6961281wre.13;
        Thu, 07 May 2020 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=kpyi58vu3gyX1xletAErxrrxhzwdDbnywpgMBtapFQ4=;
        b=AsZDz773E3K0yRR+5s1xS9m240dLj0UQolFlBX+E8jwJrIV1aKWIgfq/YI0jhF6qeZ
         e+eCJvHtqcdZMyRw6znep+gfyVw6140lXt/F5/90BAGbJ66Sj+KdArEM97epOVhIt6lB
         uFYvJYyKrPoKMqsHqLOOwmMcLgmHwCl7zdri95gVyzFcKyC1TjhaN+qHeK6YnDUPWFxU
         R94xmOTPGs2SueHVOEz6VAO0kW9ke3aY2fmUjtBn5sxoIpNSQYs6yI/jpeYS1IpbJJgZ
         v5nuRoBXN1G1VjQRrZFeM+qJgzLMpjOC5xBerinaJKfVBZ7cLpWD/Fc6ONbGVkld6pEU
         gFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=kpyi58vu3gyX1xletAErxrrxhzwdDbnywpgMBtapFQ4=;
        b=LA+LHCe2tvYI1HB60XQtP7doTJEhaiUPiHNO4yX69RAFXNxEKzCPdRlruUtI2pd2FL
         +qXYaMLX1/TbYhdE/RsZ8IXf1FLbQyKEu4IWBZmmlvSrajvYtHT7yfItNq3vnWroh8Tk
         f+BCq+OHAqD7f5hXemYpelDrOYSTBw4F9czRDwHG14ygEchya3E7E0OxSbe8WAO+No2i
         /JGcclD/UacTC8Qc4YMPDp4DUGTwm5fMgBLAxDQkE+ucqcI720rQ66uGK5KUrYxmG5Dc
         T7XevJQncCotyZ/HGUP6igdmJkWwvWX3id4WodSarF1ND1Pkse6tojG2YnINTNxeHJ06
         bwBQ==
X-Gm-Message-State: AGi0PuZ9Pus9rnoXGTvYi2aZkYnDRmAJYOU5iqt8DSstGIi9ApqTzO9B
        ymXnkTAfOt1pi5uYCp9kXG9kHFvDwgXlolfy
X-Google-Smtp-Source: APiQypIwIR8SgYTDuadIC6JKuy4zOUybN888CaaszC8gq5a8zpwRWoOlU0QUmViKL23NCxX9jIn0Kg==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr18035443wrp.142.1588880079925;
        Thu, 07 May 2020 12:34:39 -0700 (PDT)
Received: from AnsuelXPS (host186-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.186])
        by smtp.gmail.com with ESMTPSA id k4sm5181128wmf.41.2020.05.07.12.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 12:34:39 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200430220619.3169-1-ansuelsmth@gmail.com> <20200430220619.3169-9-ansuelsmth@gmail.com> <20200507181044.GA15159@bogus>
In-Reply-To: <20200507181044.GA15159@bogus>
Subject: R: [PATCH v3 08/11] devicetree: bindings: pci: document PARF params bindings
Date:   Thu, 7 May 2020 21:34:35 +0200
Message-ID: <062301d624a6$8be610d0$a3b23270$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH0plL6ngkayUAAEEU7BifA9vEwhgIhhTlHAlRDbrmoPFDTgA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
> > It is now supported the editing of Tx De-Emphasis, Tx Swing and
> > Rx equalization params on ipq8064. Document this new optional params.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.txt     | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > index 6efcef040741..8cc5aea8a1da 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > @@ -254,6 +254,42 @@
> >  			- "perst-gpios"	PCIe endpoint reset signal line
> >  			- "wake-gpios"	PCIe endpoint wake signal line
> >
> > +- qcom,tx-deemph-gen1:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: Gen1 De-emphasis value.
> > +		    For ipq806x should be set to 24.
> 
> Unless these need to be tuned per board, then the compatible string for
> ipq806x should imply all these settings.
> 

It was requested by v2 to make this settings tunable. These don't change are
all the same for every ipq806x SoC. The original implementation had this 
value hardcoded for ipq806x. Should I restore this and drop this patch? 
Anyway thanks for the review. 

> > +
> > +- qcom,tx-deemph-gen2-3p5db:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: Gen2 (3.5db) De-emphasis value.
> > +		    For ipq806x should be set to 24.
> > +
> > +- qcom,tx-deemph-gen2-6db:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: Gen2 (6db) De-emphasis value.
> > +		    For ipq806x should be set to 34.
> > +
> > +- qcom,tx-swing-full:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: TX launch amplitude swing_full value.
> > +		    For ipq806x should be set to 120.
> > +
> > +- qcom,tx-swing-low:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: TX launch amplitude swing_low value.
> > +		    For ipq806x should be set to 120.
> > +
> > +- qcom,rx0-eq:
> > +	Usage: optional (available for ipq/apq8064)
> > +	Value type: <u32>
> > +	Definition: RX0 equalization value.
> > +		    For ipq806x should be set to 4.
> > +
> >  * Example for ipq/apq8064
> >  	pcie@1b500000 {
> >  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064",
> "snps,dw-pcie";
> > --
> > 2.25.1
> >

