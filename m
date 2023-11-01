Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F27DE566
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjKAReh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbjKAReh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 13:34:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED64FD
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 10:34:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCAFC433C7;
        Wed,  1 Nov 2023 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698860074;
        bh=AZ7FlxIgY3mFat3YE3LfxcZV9vaFbjtvd2CiHdrDoCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkQcweypPovpUSspGMtCjAHctsSyLjgOpC3UlBBPdNulRFiCGEvPp5PnVau8FH/oa
         GnBCD2dRnJoWG8XokCaU59fPYvF2ikbIAgQlF7sYqMjojw3OVOZZK5myToHFRpRH9O
         nCrQVqID2A1K1nWT8RS20fHPbBSiqG55455VuPC5t857ciRMQXPce/3D6q8rhic0gE
         ojplor16FOwW9x06v5frTYo3Wx+Z4iBBD7I8xeln2PUltuMH1EJMORWeBo1NsWz5eS
         8/tpj5FaCqpkzsh2amzhnFFSCcZ016bwjazkjb6MoEcssJZfhS7C4G1u73eNx5urGZ
         N4Pz+BJbHhZfg==
Date:   Wed, 1 Nov 2023 10:34:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION
 8d786149d78c7784144c7179e25134b6530b714b
Message-ID: <20231101173432.GC1368360@dev-arch.thelio-3990X>
References: <20231031171401.GA17989@bhelgaas>
 <da1413c0-d81a-47b6-8283-0fb3da7975e6@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da1413c0-d81a-47b6-8283-0fb3da7975e6@app.fastmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 01, 2023 at 10:25:25AM +0100, Arnd Bergmann wrote:
> On Tue, Oct 31, 2023, at 18:14, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 09:59:29AM -0700, Nick Desaulniers wrote:
> >> On Tue, Oct 31, 2023 at 7:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> >> >   arch/powerpc/xmon/xmon.c:             release_output_lock();
> >> >
> >> > That said, the unused functions do look legit:
> >> >
> >> > grackle_set_stg() is a static function and the only call is under
> >> > "#if 0".
> >> 
> >> Time to remove it then? Or is it a bug that it's not called?
> >> Otherwise the definition should be behind the same preprocessor guards
> >> as the caller.  Same for the below.
> 
> It would be nice to get rid of all warnings about unused
> "static inline" functions and "static const" variables in .c
> files. I think both these warnings got added at the W=1 level
> for compilers that support them at some point, but are ignored
> for normal builds without W=1 because they are too noisy.
> 
> Obviously, all compilers ignore unused inline functions and
> const variables in header files regardless of the warning level.

Right, this was an intentional change done by Masahiro to try and take
advantage of the fact that clang warns about unused static inline
functions in .c files (whereas GCC has no warning in .c or .h files) to
clean up dead code. See commit 6863f5643dd7 ("kbuild: allow Clang to
find unused static inline functions for W=1 build") for more
information.

Cheers,
Nathan
