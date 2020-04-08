Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950A91A2260
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgDHMzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 08:55:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41383 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgDHMzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2020 08:55:51 -0400
Received: by mail-wr1-f47.google.com with SMTP id h9so7683426wrc.8;
        Wed, 08 Apr 2020 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=IJrqIcjoTwEEZUiMbhcI7+TuN6aVCX5wdU8bhu4KfEA=;
        b=Plwjt11TpHQIXe5+H5/OdTry5rXjeuIVwFPlCTnY4WUYUp6zUzNNjqtoDGkXIzL03H
         X41WXKy/weA0VzlA+zfKsaZfbvIhVEokGNq/xOiIRKNR0YDnvpaoWj13cjn6F/o0rCRl
         YL6jhUp3anUdfLijyMfJ+MbfTP6MiTKZ/oHkYvkiCEG9vb8SE04nZtZBw5P5q3Ftnl8P
         vekLdf1+4I5rQaCFUAwmGOxzi8PiudiygrvmD2D0SWZGyHNB/0TldWvu1hEzQq8Y5zhD
         hDj8xQyajJ9G2x9b+/F/gJrvQ55+SMakv3+EfQoXyahnhoN6Q4t8RPmfHdzRJ4cbRvwr
         pM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=IJrqIcjoTwEEZUiMbhcI7+TuN6aVCX5wdU8bhu4KfEA=;
        b=O1W7me2XZU9s2D28/P5ACrYXikuB8DLeamtHFZvLGqYP7rdKrATQqRIqe6ce+ODfQq
         G56ejlJPTTkyohybAgnYi/r+0+Yj6N8RaLgv3CwLwDRC+7wjQCnvVOLet1FliA+o0D07
         oDKqowphCLAyAx6Rfhn7+V2+3wTdaG8w9k1yxuHfaFFjovJAjfAj9d4XT9xHDMEtFPde
         /weIjhnHqnUPKFz5BiYKUF2QoT5eStf1AhCyFhRz9gqJwnh8QXAnVQIaH2+95k1bwJqT
         dDm7TmfnAq0hBzQOWOY4NrgUNhqx1feakNQgyj4WIxkqtKWcPM3xw7eFHH2yc3ChiZxs
         oqIQ==
X-Gm-Message-State: AGi0Pub+F2WJbEskTJITPfzXOudTZbQajaRAx4GP0kmf4ZdzCsfldPBh
        sfvg5+rGLoRW8/y+1OZIWo8=
X-Google-Smtp-Source: APiQypLl0AJwhrs7d8Pz+/qIo+zYrF4kiSv+XDOGTpRwATawZ4h5Ticw7u9bW9aR8TO8gAjGPTPhQA==
X-Received: by 2002:adf:e403:: with SMTP id g3mr8245405wrm.295.1586350549061;
        Wed, 08 Apr 2020 05:55:49 -0700 (PDT)
Received: from AnsuelXPS (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.gmail.com with ESMTPSA id 22sm6588386wmk.6.2020.04.08.05.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 05:55:48 -0700 (PDT)
From:   <ansuelsmth@gmail.com>
To:     "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
        "'Andy Gross'" <agross@kernel.org>
Cc:     "'Sham Muthayyan'" <smuthayy@codeaurora.org>,
        "'Bjorn Andersson'" <bjorn.andersson@linaro.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Andrew Murray'" <amurray@thegoodpenguin.co.uk>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200402121148.1767-1-ansuelsmth@gmail.com> <20200402121148.1767-2-ansuelsmth@gmail.com> <b09627a8-d928-cf5d-c765-406959138a29@mm-sol.com> <053d01d60da2$49e0ca60$dda25f20$@gmail.com> <f333d990-6d76-0e04-5949-54ffe31bc0e9@mm-sol.com>
In-Reply-To: <f333d990-6d76-0e04-5949-54ffe31bc0e9@mm-sol.com>
Subject: R: R: [PATCH v2 01/10] PCIe: qcom: add missing ipq806x clocks in PCIe driver
Date:   Wed, 8 Apr 2020 14:55:46 +0200
Message-ID: <000401d60da5$0669a4c0$133cee40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: it
Thread-Index: AQLxewcL6EghaIoibfUjxKO3XpeZ4wIE8vndAX3+x+ECk40mNAECtPf3pf+JrqA=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> in PCIe driver
>=20
> Hi Ansuel,
>=20
> On 4/8/20 3:36 PM, ansuelsmth@gmail.com wrote:
> >> PCIe driver
> >>
> >> Ansuel,
> >>
> >> On 4/2/20 3:11 PM, Ansuel Smith wrote:
> >>> Aux and Ref clk are missing in pcie qcom driver.
> >>> Add support in the driver to fix pcie inizialization in ipq806x.
> >>>
> >>> Fixes: 82a82383 PCI: qcom: Add Qualcomm PCIe controller driver
> >>
> >> this should be:
> >>
> >> Fixes: 82a823833f4e PCI: qcom: Add Qualcomm PCIe controller driver
> >>
> >> and add:
> >>
> >> Cc: stable@vger.kernel.org # v4.5+
> >>
> >> But, I wonder, as apq8064 shares the same ops_2_1_0 how it worked
> until
> >> now. Something more I cannot find such clocks for apq8064, which
> means
> >> that this patch will break it.
> >>
> >> One option is to use those new clocks only for ipq806x.
> >>
> >
> > How to add this new clocks only for ipq806x? Check the compatible =
and
> add
> > them accordingly?
> >
>=20
> Yes, through of_device_is_compatible(). See how we done this in
> qcom_pcie_get_resources_2_4_0.
>=20
> I thought about second option though - encoder what clocks we have for
> any SoC but if you take into that direction you have to change the =
whole
> driver :)
>=20
> Another option is to use clk_get_optional() for the clocks which you
> have on ipq806x (and don't have on apq8064). Please research this one
> first.
>=20
> --
> regards,
> Stan

Ok I will use get optional for the extra clocks. Should I add a warning =
if they=20
are not present? Also what about the extra reset? Should I follow the =
same
approach?=20
Thx for the suggestions.=20

