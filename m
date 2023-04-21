Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272F6EB22B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjDUTQX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDUTQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 15:16:22 -0400
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 12:16:19 PDT
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B5170C
        for <linux-pci@vger.kernel.org>; Fri, 21 Apr 2023 12:16:19 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682104075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKlUKQKgLrB7w8fshbu0E+uDKbiprMpICwAXatrxAkY=;
        b=dWr+W3dX4SIW2sYPHhH4eeHKe+Cwcb4NRKUxnWQIUtSCaM9cKaIiCJpZQtjt/0fy6sE8NC
        lC7RUXKzc8I25wiPz98Az23nk4XEZOVTGU53GCA9aj635tXwOtCdqoMlzqZHADFuLyoVC1
        CR5oo7gk+8vkJzQlgDExSKmkCTG3cYc=
Date:   Fri, 21 Apr 2023 19:07:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <1e4386d3a24bbf4c70880fef2af74928@linux.dev>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional
 props
To:     "Rob Herring" <robh@kernel.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Cc:     "Jim Quinlan" <jim2101024@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-pci@vger.kernel.org,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Cyril Brulebois" <kibi@debian.org>,
        "Phil Elwell" <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=" <kw@linux.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20230418183536.GA2087834-robh@kernel.org>
References: <20230418183536.GA2087834-robh@kernel.org>
 <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-2-jim2101024@gmail.com>
 <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org>
 <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
 <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
 <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
 <20230412153723.GA2473030-robh@kernel.org>
 <ac2245fd-52c8-3255-3e54-bd8daab1282d@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

April 18, 2023 2:35 PM, "Rob Herring" <robh@kernel.org> wrote:=0A>> Some =
trees like the networking=0A>> tree do merge commits of patch sets where =
the cover letter is used as part=0A>> of the merge commit message. Other =
maintainers don't, and some want the=0A>> change log after the '---' and =
some do not.=0A> =0A> I'm not aware of anyone except for DRM wanting the =
changelog in the=0A> final commits, but that's really a different issue.=
=0A=0AI don't think anyone wants changelogs in actual final commits, they=
 usually go under "---" in patch submissions.=0A=0A> I'm pretty sure no o=
ne will complain about a changelog in the patches. I=0A> guess you just h=
ave to duplicate it if you think it should be in both.=0A> b4 could be ta=
ught to do that I suppose. IMO, the cover letter should=0A> have a higher=
 level changelog than the individual patches.=0A=0Ab4 doesn't really need=
 to manage per-patch changelogs -- they should just go under "---" in the=
 commit. When you send the series either via "b4 send" or via git-send-em=
ail, the changelogs will be properly included in the message, but they wo=
n't make it into the tree after the maintainer runs "git am", because git=
 will drop anything under the first "---" in the commit message.=0A=0AThe=
 cover letter changelog is supposed to be higher level than individual pa=
tch changelogs, so I don't think it makes sense for b4 to collect them fr=
om individual patches.=0A=0A-K
