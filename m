Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55F69248A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBJRgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjBJRga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2B75376;
        Fri, 10 Feb 2023 09:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9961561E73;
        Fri, 10 Feb 2023 17:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CBFC433EF;
        Fri, 10 Feb 2023 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676050589;
        bh=LuSVARJO5JDWmYzFcghoLV4qvNNmOQxMCNhodHNQqVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BmNkMKUkXqMjUq+3/ZjDTga9k3o+n14YEIcMQTsLrQeE2Jor8Ep8/WTo8AExenzds
         oG7D88PFyvndWeYE8gstPrWzF1hsZV15SsjWqOum8s6TZKT/iVcb7Dcc19NYvN+3ce
         XaCGiZeF35qgeQh8BN5/KhPQeD42jm+aGZctBfRdwWlycsHhWFUwfnhOJ5yKT8kvpk
         Kfnfq4NqGKdImqEobICSVwhtp+b99+hwSURf94Yh53D7tsTF2sK3DmbMBTxfBSOF9c
         iXePUTX82dtRzazSk/35ksoUSmRcQp63LQmFFdjSR0tG2Ms8GHuriLhN4YhwXj+IZj
         jwNa7Pl5KNeoQ==
Received: by mail-vs1-f41.google.com with SMTP id g8so6430653vso.3;
        Fri, 10 Feb 2023 09:36:28 -0800 (PST)
X-Gm-Message-State: AO0yUKVZmqbnowLhdVVoK83HVlOTzmQHxP1g20yvF48dEEyKdwElx60m
        nK4LuvCEnZx94CGAV4uadYnjgSHxlPtzAX9r6Q==
X-Google-Smtp-Source: AK7set8uacGPb7N1FmWDujX3YT7Vp5g3fZDW03GtDeKnYuC9LpflaTY3XDZXrfsRPCUPMTfyptdOjfL0lqUyjcY3Zsc=
X-Received: by 2002:a67:6e82:0:b0:411:6418:72f6 with SMTP id
 j124-20020a676e82000000b00411641872f6mr2915833vsc.48.1676050587916; Fri, 10
 Feb 2023 09:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20230210164749.368998-1-nick.alcock@oracle.com> <20230210164749.368998-2-nick.alcock@oracle.com>
In-Reply-To: <20230210164749.368998-2-nick.alcock@oracle.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Feb 2023 11:36:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_VhesDZO336tw=KAp88jCLdW9C6y6QDkTF7WpLkr3+w@mail.gmail.com>
Message-ID: <CAL_JsqJ_VhesDZO336tw=KAp88jCLdW9C6y6QDkTF7WpLkr3+w@mail.gmail.com>
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 11:05 AM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.

How is there an issue when any given module could be built-in instead?

The general trend is to make all PCI host drivers modules, the primary
reason this one, IIRC, is not a module is because it is missing
remove() hook to de-init the PCI bus. Not too hard to add, but I
wanted to do a common devm hook to do that instead of an explicit
.remove() hook in each driver. I suppose we could just ignore that and
allow building as a module. Unloading is optional anyways.

> So comment out all uses of MODULE_LICENSE that are not in real modules

That's a comment for the series more than just this patch.

> (the license declaration is left in as documentation).
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/controller/pci-versatile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
