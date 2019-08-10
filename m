Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B588AB1
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJKUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 06:20:31 -0400
Received: from ozlabs.org ([203.11.71.1]:36651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfHJKUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Aug 2019 06:20:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 465J5n2jRBz9sNC; Sat, 10 Aug 2019 20:20:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0df3e42167caaf9f8c7b64de3da40a459979afe8
In-Reply-To: <20190603221157.58502-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-pci@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI: rpaphp: Avoid a sometimes-uninitialized warning
Message-Id: <465J5n2jRBz9sNC@ozlabs.org>
Date:   Sat, 10 Aug 2019 20:20:29 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-03 at 22:11:58 UTC, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, clang warns:
> 
> drivers/pci/hotplug/rpaphp_core.c:243:14: warning: variable 'fndit' is
> used uninitialized whenever 'for' loop exits because its condition is
> false [-Wsometimes-uninitialized]
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:256:6: note: uninitialized use occurs
> here
>         if (fndit)
>             ^~~~~
> drivers/pci/hotplug/rpaphp_core.c:243:14: note: remove the condition if
> it is always true
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:233:14: note: initialize the variable
> 'fndit' to silence this warning
>         int j, fndit;
>                     ^
>                      = 0
> 
> fndit is only used to gate a sprintf call, which can be moved into the
> loop to simplify the code and eliminate the local variable, which will
> fix this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/504
> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Acked-by: Joel Savitz <jsavitz@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0df3e42167caaf9f8c7b64de3da40a459979afe8

cheers
