Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505125FA6D9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJJVGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJVGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 17:06:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93B550B5;
        Mon, 10 Oct 2022 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665435975;
        bh=mG5hDYjGUYAZucACN+q5mdCx5qkd2+FAlcrpCEe1Ons=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cZ22GLwjIarQYehCa5elFzUJzmEJup6luc0PVqyuhAyEDX9cIFW9qEFaX7BN0Wa49
         WOiO4+FEHzffDFgo2UCGD+fXWs2FpV5LrLo6ljV+gcEu6U8ud5WpNmO1mmSdFJGyqr
         hP2vBn+guPKXXAgr2NBlua+6uSPq0lKu5LEtZNjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.224.224] ([157.180.224.224]) by web-mail.gmx.net
 (3c-app-gmx-bap21.server.lan [172.19.172.91]) (via HTTP); Mon, 10 Oct 2022
 23:06:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-8fc2e212-180a-4605-9c39-89bb5546c51f-1665435974865@3c-app-gmx-bap21>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH] PCI: mediatek-gen3: change driver name to
 mtk-pcie-gen3
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 10 Oct 2022 23:06:14 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221010205342.GA2935945@bhelgaas>
References: <20221008164211.112944-1-linux@fw-web.de>
 <20221010205342.GA2935945@bhelgaas>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Jx6+QA/TzAAp7cAAp5KC4UM/18L2dnjb7TuI78HUc8K6HSTrfJHmGC/akuTHvGm+Rehtc
 PKRrVpAj+GAbQnYSJxUTmONrbqIBj8kwEY1y6SyZw/LNBM2bP7Mb+fAwH48aTST54Wyv+6vz8jqa
 yEo8kabekshiV9Dkzrqrm5vVgksR/08ONXLvwOvbS8mD0YZ5CyFdzeIDWUNp9kOm2EF5JRw/pCfH
 9xMc9WpWsWTIAxba129ePjMdMAFR8+RfpcH3XHIQCRlEz3EDALjf8NWy+Z3N9M6u8D/r8+/E0a6I
 68=
X-UI-Out-Filterresults: notjunk:1;V03:K0:0dnFND4pJMc=:AChKLLwdlOarbzd4q5MP4b
 4T7xuwyUlI2EVf1smEMgMq/E0GjH2yOxUu46V2Q4Mt7p9nym26a8ga9QyJoHmWoTfWnGIVwV/
 U1X8KO6zJJGbM6NSaAEfT2gr25yxh3Xz7IviaGFGZGLtxZirXhn/nmF5YhowjxmQ97gVEoI3a
 Hs/+sq/wx9BikL7/zvcz6fdLz8jPsrkM45G2ngZ1lqZNBt+Z0n9d5lj6PU79Ry3dnrPCYqJoY
 jWzpXu+0Q89+L6fvg8eEm3Z8BvwwLCuWE6FUJ7o83zEdsdiHmgWw6l4bUThPVBdMx55dI/jhl
 J1mH46WdyzO//A22NZFweR34Bfk/klinSmoDRffGkFzv5VmW1HBTtqc1N57PriO74djOvcXXA
 zP1ieUn9cCyTsrxO0DPGRjMSa6CLXPTT253uZmGawnfuLJk9D75Q61cb9dJNY6FAqlFFLPdqn
 wPbhZlugDnUOTueBGYHlNsGJUuHazDoZFSV+r7mKQVHApNx9OJK5AgNCbGOaF890dmdVTVPoH
 2/4iQ5xzySRAoulxUsr6JggDck5cmfd6EDUOCHOGjG+tlvjnSKTCblflf5UVtZXWQmkiMOIZ9
 622ts5HjdtcRSnenhzyZQCvFhYqkFek34YkLzXELCxN0puxNSsWJq4sy/bbltN6/Zd539AcU8
 4f9heA6/DNr/i07HqOpGw2OAOkjZ/du9IMJDa6tE2pbRR5RNc24GX+HRnl9Ocyeo2l2p/hjHI
 4Gw4V0Yjfgblre2boYnLkvdXgkURM3Dhi6pRRAqLznwM4BVGU6bMZDZjQ0tiKjQ8HFZcfKSMd
 SAxFXovzqnyWBZkTMUskABAtz29U6WsaZn/3mJk3Pymorf1bbhss6qGll9d12CU2Z8LG8H7I6
 YcHjnFkKU+LrrpB9c+dfpyT489AKcEstY7gtEB7lE+YuhMOS61rXWtEDmfkZ17Mb6f7Fh6uOX
 gkOwMSeisjb5ScYCCfCHun79r7hWjcKdPcksBeivYBdjy1rbua5KmodTXxGBNep54/kLiqbEO
 eGSXknvFYdcfO7r7l8Km2/WfbgfSvUW2pIECgTRMzEW5Rc3xcXaSRpcpEWMqGOgPjIifUcKi3
 SGEPzzoiZF7zFTLQgspkMv607sEKQQBqojks2bZIjKzqJZCzH5XSqpxnIYBTf2YZ8RK8NZBMa
 kGu1yuCbwjlVWLwSJabHW5TO96tqxh1uG/vbve5MEHA0KeiiWtXx5+3eDka8tKzueClXu3JfA
 jSjkwfFXExjtBSmdGVXyz1vTXz2Dr3P5zS7LvB+pR/v/4/CZ4ybsPX+4aSlRIytjeFUb0GLFb
 b4Qo8jd1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Montag, 10. Oktober 2022 um 22:53 Uhr
> Von: "Bjorn Helgaas" <helgaas@kernel.org>
> Betreff: Re: [PATCH] PCI: mediatek-gen3: change driver name to mtk-pcie-=
gen3
>
> On Sat, Oct 08, 2022 at 06:42:11PM +0200, Frank Wunderlich wrote:
> > From: Felix Fietkau <nbd@nbd.name>
> >
> > This allows it to coexist with the other mtk pcie driver in the same
> > kernel.
> >
> > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
> Looks like Lorenzo already applied this:
>
> https://lore.kernel.org/all/166125958529.60702.17839683437013330997.b4-t=
y@kernel.org/#t

ok, thx for pointing out

have rebased my tree to torvalds/master from yesterday and it was not yet =
in...but i see it in next with commit-date from august 23th

i guess pcie-part is not yet merged...sorry for the noise

regards Frank
