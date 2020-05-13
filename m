Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948A81D135E
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgEMM4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgEMM4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 08:56:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D6C061A0C;
        Wed, 13 May 2020 05:56:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so20721753wrp.12;
        Wed, 13 May 2020 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ZvYSZy3tRiVgGxrommSRZgzj0zZx86esquo5YSSVJlY=;
        b=LjeYk2vBbDldv/l0KEP5R9hh4MAw6ge/KdKd8X0nOXljYjeod0jstszKttwSCs0GNI
         RbGxIV3nrqL/lTXMpPgoyBbT+GWmzCCnGjE9h6atSQDwdgnUU0uzd3nvnE3A/B9ndH2V
         6KdsApABnSxKLH9gVNi3GVRIu29vbSd47LO8c1xLSFytwEvBF6RW6vFu4lTnc0Nqf81m
         oKk0whIebq60H5qwEa4CMrVtT5pNiFEBC8/QUPMz6O+0BQpVhFaSTsN7hu6vDlXIim62
         qgB//W9iEtH/PZLSOVBkAxZcSOmYPz4H3sruJdc11TXpd5yyw/UeA8MFmf4BzkFOpo5V
         qRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ZvYSZy3tRiVgGxrommSRZgzj0zZx86esquo5YSSVJlY=;
        b=YuurCNbZvgWIUre/xLr88FauMGlQtCYUFZwiKd5NNRAre3gYS6RqOFxmtA51VQQJUx
         9J0fIWhNe5RTZMy/pXsoZTWfuyJP7rwFzYtnQEVnXH+eEEoQfxS2MrMwzI1NWBffpexJ
         Y1c5/GsW2ddNzlZHbMdjW+oNmcWcPe9KGY+208rEQQvS5JsHVIaxaxtF60sBW7cz8vY/
         hxTucXEZq2y4KGAjR8kNYc9Sy9sX/SMdzeuYGyyHDhjtDV6rve7qQ4NA8SJelPKdWD46
         pgVoYgntFGUDsJUSSqH9vj/rUqJrNUIP4BmU5MBMWqs69WM5uyA7NriSTCVDfxM1J/3u
         NVdA==
X-Gm-Message-State: AGi0PuZyRFp+UcW03c3aNTp9zMQFsLXd84fFNltVE9u935pSqgUpoY38
        YEhPCV4ITZNuKms5bXD07fQ=
X-Google-Smtp-Source: APiQypJY2NANe8ct5IeGA83GoQ+oOMnFGXo9dSTJfF15HLlU84+nNZU2dVYmm3RJ3HYsgtQf2PxiYQ==
X-Received: by 2002:adf:93a3:: with SMTP id 32mr19914479wrp.124.1589374566990;
        Wed, 13 May 2020 05:56:06 -0700 (PDT)
Received: from AnsuelXPS (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.gmail.com with ESMTPSA id e5sm24239142wro.3.2020.05.13.05.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 05:56:06 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Rob Herring'" <robh@kernel.org>
Cc:     "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200430220619.3169-1-ansuelsmth@gmail.com> <20200430220619.3169-9-ansuelsmth@gmail.com> <20200507181044.GA15159@bogus> <062301d624a6$8be610d0$a3b23270$@gmail.com> <20200512154544.GA823@bogus> <99f42001-0f41-5e63-f6ad-2e744ec86d36@mm-sol.com>
In-Reply-To: <99f42001-0f41-5e63-f6ad-2e744ec86d36@mm-sol.com>
Subject: R: R: [PATCH v3 08/11] devicetree: bindings: pci: document PARF params bindings
Date:   Wed, 13 May 2020 14:56:03 +0200
Message-ID: <02e001d62925$dca9e9a0$95fdbce0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQH0plL6ngkayUAAEEU7BifA9vEwhgIhhTlHAlRDbrkC9wKkJgJCaswEAWN8iguoEGkfMA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On 5/12/20 6:45 PM, Rob Herring wrote:
> > On Thu, May 07, 2020 at 09:34:35PM +0200, ansuelsmth@gmail.com
> wrote:
> >>> On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
> >>>> It is now supported the editing of Tx De-Emphasis, Tx Swing and
> >>>> Rx equalization params on ipq8064. Document this new optional
> params.
> >>>>
> >>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> >>>> ---
> >>>>  .../devicetree/bindings/pci/qcom,pcie.txt     | 36
> +++++++++++++++++++
> >>>>  1 file changed, 36 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >>>> index 6efcef040741..8cc5aea8a1da 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >>>> @@ -254,6 +254,42 @@
> >>>>  			- "perst-gpios"	PCIe endpoint reset signal line
> >>>>  			- "wake-gpios"	PCIe endpoint wake signal line
> >>>>
> >>>> +- qcom,tx-deemph-gen1:
> >>>> +	Usage: optional (available for ipq/apq8064)
> >>>> +	Value type: <u32>
> >>>> +	Definition: Gen1 De-emphasis value.
> >>>> +		    For ipq806x should be set to 24.
> >>>
> >>> Unless these need to be tuned per board, then the compatible string
> for
> >>> ipq806x should imply all these settings.
> >>>
> >>
> >> It was requested by v2 to make this settings tunable. These don't change
> are
> >> all the same for every ipq806x SoC. The original implementation had this
> >> value hardcoded for ipq806x. Should I restore this and drop this patch?
> >
> > Yes, please.
> 
> I still think that the values for tx deemph and tx swing should be
> tunable. But I can live with them in the driver if they not break
> support for apq8064.
> 
> The default values in the registers for apq8064 and ipq806x are:
> 
> 			default		your change
> TX_DEEMPH_GEN1		21		24
> TX_DEEMPH_GEN2_3_5DB	21		24
> TX_DEEMPH_GEN2_6DB	32		34
> 
> TX_SWING_FULL		121		120
> TX_SWING_LOW		121		120
> 
> So until now (without your change) apq8064 worked with default values.
> 

I will limit this to ipq8064(-v2) if this could be a problem.

> >
> > Rob
> >
> 
> --
> regards,
> Stan

