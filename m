Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7968788A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 10:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBJQ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 04:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBBJQ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 04:16:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F210D3;
        Thu,  2 Feb 2023 01:16:25 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g9so724249pfo.5;
        Thu, 02 Feb 2023 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u7YQu/WO3eM+W94Axx2uArQXlfnP7ugStkR0HzuieuI=;
        b=O9mxZuGxBQeDOutz5w00gArk1DwRjWPniGOOjKmeapgVBf/9Bfn4uxlnr814v6+j+p
         v1v4BXcLWScRYfwbCeZ3tfmDN+/b8qmUe4wA0Y7/R5ULXEf49DXIq1pDlQpNGzS9QuLg
         zOIQhbbvtgl0hswdDULZUvjzUWzJOMB53b52kbcwQMPlxvHEHH9nLr0wRrMOwNWYlOfK
         WzoUGj+jFhIlWljQzSmMpM/Du3nAggktkt1AfyKntjeLi4DSv9D7jrrqqU88APGcSwRe
         GgTjQUqk8O6vXW6b1Tl8uCb8ZqwtRm+NUhmaxo912MNiSlKGxUyHPCPEFfeRYYF8etBT
         sPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7YQu/WO3eM+W94Axx2uArQXlfnP7ugStkR0HzuieuI=;
        b=GKkGXAkUrQAkoPoc0pQOrgMeySqx6kpweACtcuzok9WnKswM0s/BlUZD/pyCqeEZEu
         quAXZQOJ2XR4nq6/CNNx1qShBFTBa6p3qOI3SmJlX10jnsRNwJ1NYWbj1lA913Cws5nj
         Mbyp8q22o2ogTtCiZuH573rSez7nQEBG+JLJMuSbekKp4uHqlZ8O3gnSAWJ99CpDc476
         Q03ppn1Xt6QsPcWENtzpf3SRYDRSSZS4n1IsY9nRn3YOvk/6VKHIxijwvvwqX/6t0xhj
         1c8R1VzmV6d21uzLNlTcEhXXJXzRGORpXGm3U3U1V2BqyQIVGnd6cbhvyaq6VZYNcIRB
         cZwg==
X-Gm-Message-State: AO0yUKVpIkZxWmacP4ZpnCRueTMZip54sGNGhRrxBdtoplrj2IhmuA2m
        puLlZeQBcrNfmlcFe9cQAfjTEP+c1RltwgOvLGk=
X-Google-Smtp-Source: AK7set/491DAqjUqdii7EeQPEwXiEjaCYsfj/TOFzJKuhijlTWcyilh8ZJ37x0W4yleGdnWnKgo+L0LsWJ/Q7iM+Gh4=
X-Received: by 2002:a62:cdcf:0:b0:58b:c6d6:d8fb with SMTP id
 o198-20020a62cdcf000000b0058bc6d6d8fbmr1230063pfg.15.1675329385132; Thu, 02
 Feb 2023 01:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20230113164449.906002-1-robimarko@gmail.com> <20230113164449.906002-8-robimarko@gmail.com>
 <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com>
In-Reply-To: <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 2 Feb 2023 10:16:14 +0100
Message-ID: <CAOX2RU5Y642gWMSaK6fJ2tz=9N2AO-1fFhL5=wfLeTWWkVjz7Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, bhelgaas@google.com,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 30 Jan 2023 at 18:11, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 13, 2023, at 17:44, Robert Marko wrote:
> > IPQ8074 comes in 2 silicon versions:
> > * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> > * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> >
> > v2 is the final and production version that is actually supported by the
> > kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> >
> > Finish the PCIe fixup by using the correct compatible, adding missing ATU
> > register space, declaring max-link-speed, use correct ranges, add missing
> > clocks and resets.
> >
> > Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> I was reading through the pull request today and saw this patch
> along with the Gen2 one:
>
>
> > @@ -871,9 +873,9 @@ pcie0: pci@20000000 {
> >                       phy-names = "pciephy";
> >
> >                       ranges = <0x81000000 0 0x20200000 0x20200000
> > -                               0 0x100000   /* downstream I/O */
> > +                               0 0x10000>, /* downstream I/O */
>
> Fixing the length here seems fine, but the bus-side address
> still looks wrong: 0x20200000 is way outside of the usual
> port ranges from 0 to 0x10000 on the local bus.
>
> > -                               0x82000000 0 0x20300000 0x20300000
> > -                               0 0xd00000>; /* non-prefetchable memory */
> > +                              <0x82000000 0 0x20220000 0x20220000
> > +                               0 0xfde0000>; /* non-prefetchable memory */
>
> I see the total size of the memory space is under 256MB. Are you
> sure that there is no 64-bit BAR in addition to this?
>
> I also see commit 7d1158c984d3 ("arm64: dts: qcom: sm8550: Add
> PCIe PHYs and controllers nodes") introduce the same broken
> I/O port range (oversized 1MB space wiht an identity map) for a
> new SoC. This should probably be fixed as well, along with
> reviewing the other ones.
>
> Has the I/O space mapping on any of these actually been tested,
> or just copied from one SoC to another? Very few devices actually
> use I/O space, so it wouldn't be surprising if it never worked
> in the first place.

Hi Arnd,
As pointed out in the commit description, the ranges property was copied
from the QCA-s downstream 5.4 kernel [1] as I dont have any documentation
on the SoC.

I have runtime tested this on Xiaomi AX3600 which has a QCA9889 card on the
Gen3 PCIe port, and on Xiaomi AX9000 which has QCA9889 on Gen2 port
and QCN9074 on the Gen3 port and they are working fine.

[1] https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.3.r2/arch/arm64/boot/dts/qcom/ipq8074.dtsi#L834

Regards,
Robert
>
>        Arnd
