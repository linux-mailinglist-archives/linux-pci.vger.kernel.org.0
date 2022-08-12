Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738A5915F6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiHLT2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiHLT2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 15:28:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F6B08AC
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 12:28:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r17so2553470lfm.11
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WmUtPVXDzYYViofItgm5OWBWBvLbosAnVrRqXx4fzYg=;
        b=2OV8PHEgsh0BJ5akjEDeqMXgSBv3lwpcGO9G5PjBy08miozmpeXKh75fG9k6rxrbWY
         F86FbNj3txn9ys2fmeriUzcpI2z2hEL/wYym7Xo5drjG3rKHuLFz1JdqktIzlYNrpSCe
         yMk/AzWYrgF8MqYY9jv6huCp9EgVzd+K2WQccCp7xucTrnnMeQIgq6M+aua3NCIIBSPB
         3ikS1DlidVuk8HjkT8bfem9J08Kle7B1xn2JIl2G8NaVLTrkOoHs/fY9A198AVjXWAuf
         pwFYrAVd+Iupxqr3wnx8o4xREWLamHDikpX/NvObOYzoAMy8pFkx3QHJkt/GngwId5h+
         w+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WmUtPVXDzYYViofItgm5OWBWBvLbosAnVrRqXx4fzYg=;
        b=J9HBtTjzrtKzWUER8q0bamighOuW2U4v5zYmvB+1rKyas77IWCZZ4+ovd1n7ELqi2d
         7wXxNZoJ43ZcKNt+avouf9Xm3HObpxYBVZSdXkHvkthcIzCAZUNQKVxxtvm6AFFcAfvX
         FDNqd30Glio/bL9A5a9koa0cKLnZJ5zuYlmECvG5mon0vH5c1BvWG+CXh4TYX9BdZypo
         eyxCykuemWETCEX6NHAmdFBX65a0ayOChFX4sAbt/BLcjYcevx0nBAJAjWMrlqeiHKLm
         mzITVeNLTuZthLO35OOgeqlAich5HjTICL5RkiL4LDX6kBAsvb0KNxNASyaRPcTi/1kV
         k1mg==
X-Gm-Message-State: ACgBeo0yCxhSlo/Fw2M2Y8rVYC2A/fSgIcGHvpQuM9c9PhCwE1B7H13s
        ZhyxOF9jDiydbL3Mwb8xlbN6ByTAlAK0opTN8kWe4A==
X-Google-Smtp-Source: AA6agR5E8qo2iM9exMW3SiYuxVnODbdG1EDkqjmcZGLxU36XqU0w6V0nGASn7tM9/yFp1PEAYkGVx4FhfZU5ed54eAE=
X-Received: by 2002:a05:6512:e8b:b0:48a:d7f8:a102 with SMTP id
 bi11-20020a0565120e8b00b0048ad7f8a102mr1610719lfb.60.1660332499310; Fri, 12
 Aug 2022 12:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <YvZgJ4IGEG8levOA@kudzu.us> <20220812192124.GA1678588@bhelgaas>
In-Reply-To: <20220812192124.GA1678588@bhelgaas>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Fri, 12 Aug 2022 15:28:05 -0400
Message-ID: <CAPoiz9wzCSRtxZ404BpLM-SA0Mv3OAZwJopreiH84ZuE1rVJKg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several globals to statics
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 12, 2022 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 12, 2022 at 10:13:59AM -0400, Jon Mason wrote:
> > On Tue, Jul 12, 2022 at 03:05:27PM -0500, Bjorn Helgaas wrote:
> > > Handled via Jon, I guess?
> > >
> > > I'm unclear on the future direction of pci-epf-vntb.c.  Jon, are you
> > > signing up to maintain this?  MAINTAINERS doesn't seem to reflect
> > > that, even in next-20220712, so you're not being copied on everything.
> > >
> > > If you are planning to merge and maintain this file, it would be
> > > helpful to me if you acknowledge patches you merge so I know to ignore
> > > them.
> >
> > I massively dropped the ball on all the EPF stuff.  I appologize profusely.
>
> No worries, sounds like you're getting everything sorted out :)
>
> > I'm pulling it into my ntb tree bcause of the patch dependencies.  If
> > you want me to own this stuff because it has ntb in it, then I can do
> > a matainers entry to reflect it.  My assumption is that because it is
> > under the drivers/pci umbrella it is yours (unless you want me to own
> > it).  100% defer to your decision.
>
> This patch dependency thing feels like a one-time or at least unusual
> situation.  Unless it becomes a problem, I think it makes sense to
> keep the drivers/pci umbrella instead of carving bits out of the
> middle.
>
> Even if I continue to merge everything under drivers/pci, maybe we
> should consider an update like this just so you get cc'd on updates to
> these files?
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08a5d70ceef9..5bafe7e8c2b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14466,6 +14466,7 @@ W:      https://github.com/jonmason/ntb/wiki
>  T:     git git://github.com/jonmason/ntb.git
>  F:     drivers/net/ntb_netdev.c
>  F:     drivers/ntb/
> +F:     drivers/pci/endpoint/functions/pci-epf-*ntb.c
>  F:     include/linux/ntb.h
>  F:     include/linux/ntb_transport.h
>  F:     tools/testing/selftests/ntb/

Works for me.  I can do a patch to add this line to maintainers, send
it to the people on this thread, and pull it into my pending pull
request.

Thanks,
Jon
