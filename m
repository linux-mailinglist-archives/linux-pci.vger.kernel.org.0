Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7750320A5DE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406418AbgFYTc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406329AbgFYTcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2020 15:32:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA4C08C5DD
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2020 12:32:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so3787777pjc.4
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2020 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aiCyaSfPElHdBJ1rU4jQnvBfG3hDID3mTTJS9XuQz+Q=;
        b=mDZm0gGa4yZbKDGF9rgasIeYxWV9KiHwNiMw4ndiNsCn3uE7R//SGEQLJE3mdDSI9/
         HpYkrdPyVuwor8peEnUfcbBGXiofFnd9veTD7NWibiAP8Ve8E8gCOzG31rjOvREFV1Bf
         JgsOujSu3baR0YmlQhh5NEYw2pxgOkuVQSleeQxner2eUY5rh1bZK2fJ9oTRt0snh+M+
         w5fHbf1pXC29S4Vdgqgal1yygHmQF+xISjlsoEB9iBq9A7j/gBZC02UXmgSOGcV/V0l2
         EEwNoJRyrtCrwRdjdM5UwbSh/doG0vV/wAS2jKyrjWA8airu6HPV73/rpljmn2VIho8e
         Lz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiCyaSfPElHdBJ1rU4jQnvBfG3hDID3mTTJS9XuQz+Q=;
        b=Eus1e6E6ToKfinJmHZpdpT3NZZanfSCzdjp9ykDGkDYKVhqUk9z09eHOUOv5mVw6RO
         La8+h1lUUiI1ZITb4ib1svAn0JZaRIyIpcOSmKNGgUn3MrMoff4Luo0GU7yVgI0MUfae
         sdwmnmIvnqg2USAO25LG50KEEF7JhgGSE2XErcDLmLVyWHsAztQqKlhveXKsOj+Cs7BK
         x6o4XNrbREeELxHqGyWOjDkCqRqxyI6wq5WbUe2OCLEr2aM3XNUNo/zhAE92CABTHxDd
         tVTEJDaaPOejAI38TxIdJ6y+fswB2OqUkJdsHJwzb43e8q5xo+AT52JStqfHuscv1mFX
         sMeA==
X-Gm-Message-State: AOAM5307keh+wHRixe3r7p0uwDsRta11UhPoxbFl1YO0Xe5wphrQ9CpI
        ZS8AzMnH0f3MlRvpCDDfMPRQ2A==
X-Google-Smtp-Source: ABdhPJzHjBuSoIFTZJ1sk5l9LqVn8mN4nFIUCyUrTGu3HSZs8Ut1ULHUwpBV+FgkM8L4HnNscu3bNQ==
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr5103958pjb.51.1593113544026;
        Thu, 25 Jun 2020 12:32:24 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id c141sm9061908pfc.167.2020.06.25.12.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:32:23 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:32:17 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Message-ID: <20200625193217.GA59566@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
 <20200624214925.GB120457@google.com>
 <20200625074716.GX4817@hirez.programming.kicks-ass.net>
 <20200625162226.GC173089@google.com>
 <20200625183351.GH4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625183351.GH4800@hirez.programming.kicks-ass.net>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 08:33:51PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 09:22:26AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 25, 2020 at 09:47:16AM +0200, Peter Zijlstra wrote:
> 
> > > Right, then we need to make --no-vmlinux work properly when
> > > !DEBUG_ENTRY, which I think might be buggered due to us overriding the
> > > argument when the objname ends with "vmlinux.o".
> > 
> > Right. Can we just remove that and  pass --vmlinux to objtool in
> > link-vmlinux.sh, or is the override necessary somewhere else?
> 
> Think we can remove it; it was just convenient when running manually.

Great, I'll change this in v2.

> > > > > > +ifdef CONFIG_STACK_VALIDATION
> > > > > > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > > > > > +cmd_ld_ko_o +=								\
> > > > > > +	$(objtree)/tools/objtool/objtool				\
> > > > > > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > > > > > +		--module						\
> > > > > > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > > > > > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > > > > > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > > > > > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > > > > > +		$(@:.ko=$(prelink-ext).o);
> > > > > > +
> > > > > > +endif # SKIP_STACK_VALIDATION
> > > > > > +endif # CONFIG_STACK_VALIDATION
> > > > > 
> > > > > What about the objtool invocation from link-vmlinux.sh ?
> > > > 
> > > > What about it? The existing objtool_link invocation in link-vmlinux.sh
> > > > works fine for our purposes as well.
> > > 
> > > Well, I was wondering why you're adding yet another objtool invocation
> > > while we already have one.
> > 
> > Because we can't run objtool until we have compiled bitcode to native
> > code, so for modules, we're need another invocation after everything has
> > been compiled.
> 
> Well, that I understand, my question was why we need one in
> scripts/link-vmlinux.sh and an additional one. I think we're just
> talking past one another and agree we only need one.

We need just one for vmlinux.o, but this rule adds an objtool invocation
for kernel modules, which we also couldn't check earlier. We link all
the bitcode for modules into <module>.lto.o and run modpost and objtool
on that before building the final .ko.

Sami
