Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543AE6DBF47
	for <lists+linux-pci@lfdr.de>; Sun,  9 Apr 2023 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDII6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Apr 2023 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDII6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2023 04:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2C4C1B;
        Sun,  9 Apr 2023 01:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E32F601BE;
        Sun,  9 Apr 2023 08:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D88C433EF;
        Sun,  9 Apr 2023 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681030726;
        bh=ZBQa6HSvHmlOsAAI9bKj5LL7zo5aODnHk6E1IvSRNP8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=K0psEaAlENTLBDgQSrdsQr1gG0H6zeYuLmcSeimr+6nsHBZe+CVwKbnn/xw9RUzYI
         YBe20g2aysR7jNr7GHyNpFjPW8F790RovaiMfUMXNkpvaLG7GU3behFGsUzgW3XFRC
         28yV0WWfBnTjkAM+crF3WkQwjmkfNQpwwnb3+vtbenDIEfq/eL5qy6TaaqiK4qgykc
         0/Qcm1ZontBvazim7p6UQKJKabt+2F+7ro7JxRyOY2sFJ11ReERoZ7qqNpyJ4xDPha
         cHZK6M1kP90XxDoLPSCvJ+BUVR9xs3Wn0wPnYfN1beensl/9gu//hUSb3lB0cixcd3
         lFsbzS/8iYPcA==
Date:   Sun, 09 Apr 2023 09:58:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_0/4=5D_Convert_SiFive_drive?= =?US-ASCII?Q?rs_from_SOC=5FFOO_dependencies_to_ARCH=5FFOO?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZDEAD5aWhvMxAj8F@infradead.org>
References: <20230406-undertake-stowing-50f45b90413a@spud> <ZDEAD5aWhvMxAj8F@infradead.org>
Message-ID: <834F56B9-E394-4F7C-97D8-BAA97F03362E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8 April 2023 06:47:59 IST, Christoph Hellwig <hch@infradead=2Eorg> wrot=
e:
>On Thu, Apr 06, 2023 at 09:57:46PM +0100, Conor Dooley wrote:
>> From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>=20
>> RISC-V's SOC_FOO symbols for micro-archs are going away, and being
>> replaced with the more common ARCH_FOO pattern that is used by other
>> archs (and by vendors with a history outside of RISC-V)=2E
>
>And this is still the wrong way around=2E  This ARCH_ madness must not
>spread=2E  NAK=2E

As I said when you complained last, we asked the arm lads and there was no=
 interest there in doing things differently & that's just one architecture=
=2E
Nor was there in adding a SOC_ symbol from some of the people who do more =
than one ISA=2E

You're welcome to send reverts for my first round of conversions and patch=
es converting all the ARCH_ stuff RISC-V has to SOC_=2E
I'll happily ack a complete conversion to SOC_=2E
I don't care if it is arch or soc, I just want things to be used consisten=
tly=2E


