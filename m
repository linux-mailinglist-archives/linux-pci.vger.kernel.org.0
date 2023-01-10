Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD7664539
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjAJPrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjAJPrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:47:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204544C51
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 07:47:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 200so2988307pfx.7
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqAonkvvlkjP3xf6w+ybB+UtrnG/dwyrsl+5Eu8mqc8=;
        b=mf/FK5QQ/vY8QNUoC+WI5SG18LUF8Xluig+DDuFtLBqLVw5dgihnvVzK7W+Ppyh269
         loiqyPI3tiYgww9XXoKRNXiu5kWzC8qeSGFlzagrNlwFaiop0VTNDAfyboGd5suCbcoO
         DOcOduMPFb8sHqfltXjBPKTGXIgikMDhANtS+gatesjve5RBGazeust3y4Q6ltlZuzxo
         lrZ8XMpCJDzJ1vqdC0Wr8P+ETEdHhS+TI91RGEss/pgVvky6iXVFLdrVUnhOpk6rYpab
         T1/o50CZkdIjqF7C8BWjlr7IenQjp5XFPPoK96RdkQFOAjAdCSFCi0VgsTzmfclxu6+H
         2Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqAonkvvlkjP3xf6w+ybB+UtrnG/dwyrsl+5Eu8mqc8=;
        b=iIxrzKLFQP2SVA7VReYKLngRVGjnkRihIAUtdtZfXuRMsICckVG1mLdjdVXnC/Z2Z6
         QE5VfudP8kX5MHa2u8tAKLS4YB3huyKBRKtuLjTl5Mi/rftJV4DVqCBFbAiWNcPl/2AZ
         N1CEDUTnuiXil5Pt7005ZPXeSZVOya2B91n45z9aJaklKMJFel90Drp5EATa5GmToVaU
         VVCs8b0VgP5Jh827PAUi6FasPDtJyTyFEw1643RSNsMvHdViYm2mZn3K709WdbMpAsA7
         Lc+XjzyIHNXNwiXBo2qJ0cY4sXp7Z2rbyM4qCJ9Ca9bgM/CpbA0BeHxycSdryy6Ba4R2
         aTdg==
X-Gm-Message-State: AFqh2kp2ybjyLcIuApymTZHA3Gux3MM0SO3zimfpoY2/QXZl9NoTpuhG
        rVFsZcof+ptsF7nAYpkSuVUXdW6tf0VGsNgx4S2SYQ==
X-Google-Smtp-Source: AMrXdXsURvGSkkSc47ezsF3JNgU2Nl01yJsOr807CaAaqedHJcAD6cgm3G2hlvTSKbCOXRiBQXM13PbppreWaK5XaeY=
X-Received: by 2002:a63:eb07:0:b0:4ad:2049:2aa6 with SMTP id
 t7-20020a63eb07000000b004ad20492aa6mr1148308pgh.550.1673365634426; Tue, 10
 Jan 2023 07:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20230109080453.1155113-1-alvaro.karsz@solid-run.com> <20230110153434.GA1505598@bhelgaas>
In-Reply-To: <20230110153434.GA1505598@bhelgaas>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 10 Jan 2023 17:46:37 +0200
Message-ID: <CAJs=3_Cx1Pxg4iwLY5eWV9RVJoJ-btZVop3rHhzFmtErMJzj1Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
To:     mst@redhat.com, Bjorn Helgaas <helgaas@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn.

> This should be indented with tabs instead of spaces so it matches the
> rest of the file.

Michael, sorry about all the versions..
Do you want me to fix it in a new version?
I could fix it with a patch directly to the pci maintainers after your
linux-next is merged, if this is ok with everyone.

> It's helpful if you can send the patches in a series so the individual
> patches are replies to the cover letter.  That makes tools and
> archives work better:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.1#n342

Yes, I fixed it in the next version:
https://lists.linuxfoundation.org/pipermail/virtualization/2023-January/064190.html

Alvaro
