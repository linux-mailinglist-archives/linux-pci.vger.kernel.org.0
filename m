Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C85952C3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiHPGmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiHPGmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 02:42:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9E14EBBF
        for <linux-pci@vger.kernel.org>; Mon, 15 Aug 2022 18:31:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so12856128lfl.13
        for <linux-pci@vger.kernel.org>; Mon, 15 Aug 2022 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7TyoM62NCZIF/E5AFBSvac1IoKHCKnc+Y34dVW1eFns=;
        b=52twqYpswvNn+4ufPoVuXYwtbANQzS3ciJHHysFqnHecqsLdTFoUN61U2QnWgSOr/i
         TQXgO1Kgv9T1Y5tejanZLTzhnIOUEsj5CMpDvBvcmdPa8Ln6VeZXc+jRILGAocJ6E8RW
         7y08HcEa1rce+7Swcc0KuD+qTjLsrwqbtFz126x5RHIN/0PddL+W1xRRoH7AH1YRe/Rp
         CXDOW5VF9sZxW9yiFOQMjwzFnMIDKsAw/XyYbFvxPA2rDgUt1AgEnHLi0I5dZKVeURfk
         ZP4BOyrrJzorHKeWyI48/PMOKhIAdiBwuCr9OkfvKfwMUdHgOk+7ncSIvuE5Zpd605x2
         Q6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7TyoM62NCZIF/E5AFBSvac1IoKHCKnc+Y34dVW1eFns=;
        b=jaf+fyHDmRBFXj07uv91kwHeuZ99lHrQlyt6+73huqff2A+wag2OjfL06gZ1MHyno6
         9YLqwKewLAIp3O//BU+cBsWqggeHhx4ondUGhgmY1BBsARJxcU6Rb48T4FUkD1UYIU5z
         HJOtveL9OCFjKslGhxHtsEg785XMT0NsDmTFnuwyl8OyBatQM8L3NvS0wC//nn+1ymdd
         lQq7QwklHepEruWZy8e//LIY64upGPikVy40d3SAcywM8tMn2hF4SaYVrdDn5cO7++he
         xdJdncoayFoqkrrlp9yEGw/MiRVSaIJ8qS4UEzxQk+103OSW4CO/7rANMzWSpsxy9rVr
         bDwQ==
X-Gm-Message-State: ACgBeo1JzenimUsu0jSwr6NskN++scd492XOifZTurNXQ4T8s2HcoPWt
        mwGkM33udav8M7yJVbIEYrGqi2qwvZS0mZWU7Z+A5Q==
X-Google-Smtp-Source: AA6agR49I5XQ54GRFcSaPPrWeKWJQ1VX4qlPtuaRTyVtiXCjCJXwKQDjJPBmvzfPhHNye0mxtkh2JKlWpGWhbwfbcxg=
X-Received: by 2002:ac2:563b:0:b0:492:8f3a:44fc with SMTP id
 b27-20020ac2563b000000b004928f3a44fcmr1878799lff.645.1660613482321; Mon, 15
 Aug 2022 18:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANXvt5osmx+iFdVXYQhGcdBiz5VsA60jzdKXg42c_zSDuxoHxg@mail.gmail.com>
 <20220815183920.GA1960006@bhelgaas>
In-Reply-To: <20220815183920.GA1960006@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 16 Aug 2022 10:31:11 +0900
Message-ID: <CANXvt5oOZfPZp6gMjS7AL=NPjUuKTXW6Co-o9w+-X3hyM0k+aQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjom,

2022=E5=B9=B48=E6=9C=8816=E6=97=A5(=E7=81=AB) 3:39 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Mon, Aug 15, 2022 at 12:00:23PM +0900, Shunsuke Mie wrote:
> > I have a question, not related to the patch. Could you please tell me
> > why the ntb related patches are managed outside the pci branch,
> > Helgaas's branch? It confused me a little to find the ntb branch.
>
> My understanding is that the recent drivers/pci/endpoint/functions/*ntb.c
> patches were merged by Jon because they had dependencies on other
> patches in his tree.
That makes sense.

> In the future, I think most NTB-related patches in drivers/pci/ will
> be merged via my PCI tree.
>
> Bjorn

Thanks,
Shunsuke
