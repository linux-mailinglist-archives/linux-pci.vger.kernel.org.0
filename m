Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57619AB58
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgDAMJ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 08:09:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38916 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgDAMJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 08:09:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id e9so6916316wme.4;
        Wed, 01 Apr 2020 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=PU0qVr5nPkx5o+ufW3vb8KGQq695uV/03Y7NY5/Qzn4=;
        b=ILmjXN8caMMj52xFvubitRb1AiZdfxDDUrsnMSYpdbcu3uIjKvPD9I28x8hds5yno/
         PAmel+QXqgeGw1XmLW6RZqDra/krmOO+1ECKgsK3eKAnV7Hf0aGpZFnU9iUkKPGA45MA
         AgVYRLu5OAaYfj20hpYXcoWc9rqbrUot56sjn4hK6iQPEs3WajKIRZ8Wn9VSzqNOgqDj
         llz4R2Lxp2auGdmnDIZiLuyV4ReFDpW1L3sSm0x6sdx1NdC+ZZmT8pXUyv+lVnBv6DLh
         xkZTtrUb2YMZ4JvHIkoxDOexX8Zo2LkHf1zFev8TmD1/8vd7mgBiwpfptzmDc4HLqY0r
         RusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=PU0qVr5nPkx5o+ufW3vb8KGQq695uV/03Y7NY5/Qzn4=;
        b=JgVf50HCVPzVkd5Ye+l88ZfRG38ZhS6jgJEmkvH4XviubNWOiz/X0cHYPLPv8fx78Q
         Nl21+33ByClWO007rvA7jN4VTYL7mYTfloJcufHoV2wm1lHggBynbGyd68VWChLss1hm
         dt1JNMOf9nFASlrGCAlNnpLCMMTBevbdkvMyFz4wjeiaCPjoDIhOph35xEqcZcltttP/
         6vedNuQw/vzjYGdctzvbybyOTpUZJaIcqEnG0emhk59lAB9Ft86MvBnWIsf7+VvFybQ3
         QEe/kintkKf0sEkaGlPRm2bpSiiNpDxULp0Ixm4Vw5oY58FeR8sLnoOWB0qncBy2ndLe
         jaIw==
X-Gm-Message-State: AGi0Pua8tBlEPBTFxhtKg+kCFATrsrardDtZzAzxrawcWTcAgpomx8sc
        w8WvO7uKe/Xh3TWOrW0XLsI=
X-Google-Smtp-Source: APiQypLPuhTh2gyvjFErd3SXKSjXWWVPFQbYzmQNmDCWTxCJLVc0uH7H6CFQmbjK42jGjvax+4s0JQ==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr4191618wmi.90.1585742996497;
        Wed, 01 Apr 2020 05:09:56 -0700 (PDT)
Received: from AnsuelXPS (host3-220-static.183-80-b.business.telecomitalia.it. [80.183.220.3])
        by smtp.gmail.com with ESMTPSA id w66sm2504621wma.38.2020.04.01.05.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:09:55 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200320183455.21311-1-ansuelsmth@gmail.com> <20200320183455.21311-8-ansuelsmth@gmail.com> <20200331173241.GA25681@bogus>
In-Reply-To: <20200331173241.GA25681@bogus>
Subject: R: [PATCH 08/12] devicetree: bindings: pci: add phy-tx0-term-offset to qcom,pcie
Date:   Wed, 1 Apr 2020 14:09:54 +0200
Message-ID: <013b01d6081e$74e3b710$5eab2530$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQF7DJ39byRpk4MoIUXZtcQDafvd5gI+20GLAtWBGGmo8YCbwA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Rob Herring <robh@kernel.org>
> Inviato: marted=EC 31 marzo 2020 19:33
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>; Andy Gross
> <agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> Bjorn Helgaas <bhelgaas@google.com>; Mark Rutland
> <mark.rutland@arm.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> Andrew Murray <amurray@thegoodpenguin.co.uk>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [PATCH 08/12] devicetree: bindings: pci: add =
phy-tx0-term-
> offset to qcom,pcie
>=20
> On Fri, Mar 20, 2020 at 07:34:50PM +0100, Ansuel Smith wrote:
> > Document phy-tx0-term-offset propriety to qcom pcie driver
>=20
> propriety?
>=20
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > index 6efcef040741..8c1d014f37b0 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > @@ -254,6 +254,12 @@
> >  			- "perst-gpios"	PCIe endpoint reset signal line
> >  			- "wake-gpios"	PCIe endpoint wake signal line
> >
> > +- phy-tx0-term-offset:
>=20
> Needs a vendor prefix.
>=20

So I should change to qcom,phy-tx0-term-offset  right?

> > +	Usage: optional
> > +	Value type: <u32>
> > +	Definition: If not defined is 0. In ipq806x is set to 7. In newer
> > +				revision (v2.0) the offset is zero.
> > +
> >  * Example for ipq/apq8064
> >  	pcie@1b500000 {
> >  		compatible =3D "qcom,pcie-apq8064", "qcom,pcie-ipq8064",
> "snps,dw-pcie";
> > @@ -293,6 +299,7 @@
> >  		reset-names =3D "axi", "ahb", "por", "pci", "phy", "ext";
> >  		pinctrl-0 =3D <&pcie_pins_default>;
> >  		pinctrl-names =3D "default";
> > +		phy-tx0-term-offset =3D <7>;
> >  	};
> >
> >  * Example for apq8084
> > --
> > 2.25.1
> >

