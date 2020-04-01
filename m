Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75A19AB4D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgDAMJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 08:09:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32969 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgDAMJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Apr 2020 08:09:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id z14so4292095wmf.0;
        Wed, 01 Apr 2020 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=yJOSxzQokynAxKi4OzeFniUvkB0GiW9QTsXtXkXYfZw=;
        b=LsdtFtwW8To/mYh4WSZE5rXUsiuoAIZ5MGpWszzGyAVvaX2rQpgJ/DLcYQwjqDsk57
         p3DMC0CzfhUZDpwUbj/O5ScAWg51Lppa+Gh+HBnPpeODozh718gePLGgb7IdOlWIwvsJ
         GayePqxBWm3Ax88f/5GKKmdlsfU1ss52fFcqUE7cOaxk2opgmBekz9AnmwmwqHGzlcjf
         YrtqztB8t/yz6nf7qR9vSym3h/3OVT+pLjfJRKAA+Z+koSPWo44hPrMU9podt8Xgyqgg
         JK2IN6L0vIO7f1/Fmke3uHB1XVvomuqkDkzL8AQm1G0fEm4XhrjnyHgrEpO9irIXVJMw
         zOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=yJOSxzQokynAxKi4OzeFniUvkB0GiW9QTsXtXkXYfZw=;
        b=EGkFFXr9s23b+0wxS3HBmCMxNYJLL8dFvwLiFjB42u+OdkOB7TjdO/cZXlHFTvBpPh
         GbNuzwUe+iAxSpGxEbYtqpI5w5j9gsvs39oc4ebKFUbn/4+ho2JFGavf8eiq3Krukdbl
         Mfb5OljKYcfxkPpnBQvfxbKlJN1YM8kf9glmrbu7/u0is175MGFnGRvPVSd7Za9V5Eh/
         EEP3u3Vm1pNG2aYqTLJLZ5oPhTY88/YXyUVl+DixRRPhqfNs6VnJIeRkIcnqz1HrIRRL
         wzzA3kWtzZLVh/0Y4ZqloXnkb+ki61Bi6WfRbE2L1SEC3bFxySfEXjjy6oYRpLKys1gq
         hBXQ==
X-Gm-Message-State: AGi0PubrbqCSSAb4uPygMI61tFuGWnwm7Z35B7i1bDpZkUckNtQiS26m
        +DzTdfmfC2t3jEWLWaQSMYk=
X-Google-Smtp-Source: APiQypJLLOoidedNbKugfpKFfkMSH+KofgB0VFkGy8A3wZENhS0oqgeJrmhw+KqxWy6cKFevCxLDmQ==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr4128505wmg.79.1585742952654;
        Wed, 01 Apr 2020 05:09:12 -0700 (PDT)
Received: from AnsuelXPS (host3-220-static.183-80-b.business.telecomitalia.it. [80.183.220.3])
        by smtp.gmail.com with ESMTPSA id y11sm2643560wrd.65.2020.04.01.05.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:09:11 -0700 (PDT)
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
References: <20200320183455.21311-1-ansuelsmth@gmail.com> <20200320183455.21311-11-ansuelsmth@gmail.com> <20200331173348.GA28253@bogus>
In-Reply-To: <20200331173348.GA28253@bogus>
Subject: R: [PATCH 11/12] devicetree: bindings: pci: add force_gen1 for qcom,pcie
Date:   Wed, 1 Apr 2020 14:09:09 +0200
Message-ID: <013a01d6081e$5aa2fb40$0fe8f1c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQF7DJ39byRpk4MoIUXZtcQDafvd5gGYkj2+AjiIiXOo+5pyYA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Messaggio originale-----
> Da: Rob Herring <robh@kernel.org>
> Inviato: marted=EC 31 marzo 2020 19:34
> A: Ansuel Smith <ansuelsmth@gmail.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>; Andy Gross
> <agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> Bjorn Helgaas <bhelgaas@google.com>; Mark Rutland
> <mark.rutland@arm.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> Andrew Murray <amurray@thegoodpenguin.co.uk>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Oggetto: Re: [PATCH 11/12] devicetree: bindings: pci: add force_gen1 =
for
> qcom,pcie
>=20
> On Fri, Mar 20, 2020 at 07:34:53PM +0100, Ansuel Smith wrote:
> > Document force_gen1 optional definition to limit pcie
> > line to GEN1 speed
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > index 8c1d014f37b0..766876465c42 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > @@ -260,6 +260,11 @@
> >  	Definition: If not defined is 0. In ipq806x is set to 7. In newer
> >  				revision (v2.0) the offset is zero.
> >
> > +- force_gen1:
> > +	Usage: optional
> > +	Value type: <u32>
> > +	Definition: Set 1 to force the pcie line to GEN1
> > +
>=20
> I believe we have a standard property 'link-speed' for this purpose.
>=20

Yes this will be dropped in v2

> >  * Example for ipq/apq8064
> >  	pcie@1b500000 {
> >  		compatible =3D "qcom,pcie-apq8064", "qcom,pcie-ipq8064",
> "snps,dw-pcie";
> > --
> > 2.25.1
> >

