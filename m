Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F6694DFC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBMRat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 12:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBMRas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 12:30:48 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651FA276;
        Mon, 13 Feb 2023 09:30:46 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7621635F;
        Mon, 13 Feb 2023 17:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7621635F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676309445; bh=+0G13RTh6TKJd+Psii2Hnwyy6W/qCSu6rqe6+5bBQ1A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V5bvl/7/rl++F9YhB+WZvzhrYMi1v31mog3I+XmrgoQBisl7CyvRhQpjApEO/6otQ
         22hRCUpCaufkRkl97rafJWbb1bHYUPmh0uKHR67gYPr+AR2qMCWpbHpOUO/yAUnfrk
         sseiyIotkQGyF03z+ixuE/q0sK4xU93okXadrQgrqtNO4Tdp21PYf8vPMaO2Vn8VMU
         RHHOeSbIPG0YiKOLBEfksz8SISGKxxJhVVPjcPn0UzHUX239SPfjIItcboIq7o9lqz
         OqDX0r9PqrJPxbt61NX7wd7LzEWKNACuM82PZ7vixL/44V4GO8Kfj09sQwSLJxrewe
         8KuY8EKPe21JA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leon Romanovsky <leon@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>
Cc:     Conor Dooley <conor@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
In-Reply-To: <Y+kx3fb2Lzlg+u5+@unreal>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com> <Y+aMh5e9bWaTphiZ@spud>
 <871qmx1fv5.fsf@esperi.org.uk> <Y+akw9VBjg9oZ7QV@spud>
 <Y+kx3fb2Lzlg+u5+@unreal>
Date:   Mon, 13 Feb 2023 10:30:44 -0700
Message-ID: <87ilg5mq0r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Leon Romanovsky <leon@kernel.org> writes:

> It looks odd to me too. Please add SPDX tag in modules which don't have
> it already, instead of commenting code.

So I'm just a bystander here and should probably be ignored, but ...

From what I can see, Nick is attempting one of those cross-tree cleanups
that's painful enough to do on its own.  This request is asking him to
perform a different, unrelated, and potentially fraught cleanup that the
maintainers of the code in question have not yet managed to get around
to taking care of.  This will impede an already prolonged process and,
IMO, unnecessarily so.

Wouldn't it be better to let this work proceed while making a note
of the files still needing SPDX tags?

I'll shut up now :)

Thanks,

jon
