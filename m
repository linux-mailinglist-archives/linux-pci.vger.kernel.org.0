Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083AC5A9778
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiIAMz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 08:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiIAMz5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 08:55:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D616B6050D;
        Thu,  1 Sep 2022 05:55:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c59so16215191edf.10;
        Thu, 01 Sep 2022 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jhfzIaUon51fYQp0F1k+dFqo+kZvbfWBW8TIyHPfH9o=;
        b=jMSC0YquDnvD/wKHI7Bl6kt3HP8PI5qhhb7sTMXUL+2sSZjhkC4vH4MxakkmvLKGjk
         QPxjuyey7HagF+AKEaAsGWlUWccERGb/0c3siHGQcJRHzMwkTFAm8yI38icYY1dnI/ZR
         aJcp7GhNNHp+/NeWvUyqk16WaRrTwzCxLwMXc/YmVsxcBaTyarMh4CYu0gU1Afya2nQt
         Y97YDdJE3S2oo7RCBbDVSvod461mGchoBGCr7dPjHgA/TAl8PQAqmeFnn+NUzkyI6D68
         xImxBql/4xfUNMzoJes4HdZqS7VmJqHI1VM19eEqRUgI6esl0d1vJLnCn1eSCqjldWcB
         bbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jhfzIaUon51fYQp0F1k+dFqo+kZvbfWBW8TIyHPfH9o=;
        b=fwKXAYKXd5Oir65B6LZBzHxAlIYReV1lkVmQoSuzJWVI85NibNhTTd0uPic3DrSyF4
         /HRRXQ8vN3av0ztVitbl+wYD78S2nf5wVVSmQ9sV/oUOFB7opXPOCPUuWD0ysr6+Vmt4
         gHpGM2WYT6hyj/BEXiagHIfFc/JYo4imJmqGKZtAYg4sgxt7tRGor+AeqgOgIN9GLp09
         t8Yha4g87rkOO2IVe4eSEsn/snrcp2vRCXfEUSYW7SqCf2CeO2tgtji2C19KezEOa2fN
         Vt01650+YWP1MH6Tbk9WuglgCncng0tRbAB9ewadmNloWes7U8yw/h3HIK4VGZ6tpmLy
         BwHg==
X-Gm-Message-State: ACgBeo17cmafgZXx9U5+eZKh/tm6dlJ/WHML1ZEFM5fflOmq3BNxr9GW
        NlSVr3R5ZLp+LI87pzsF7U4H7UWOk60jjL+KXl0=
X-Google-Smtp-Source: AA6agR67InrKUxArKpIRlcyj7cVISplMIgyuL+xsXdnE6v/afHMiKYTX1RTDY2PSTc+Hfk6DW1c51JwwhoW8mNZLH7w=
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id
 h22-20020aa7c956000000b0043b206dc283mr28605542edt.381.1662036953082; Thu, 01
 Sep 2022 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220829151536.8578-1-jandryuk@gmail.com> <31F127F6-A096-4991-9D4C-1B2E032689A1@gmail.com>
In-Reply-To: <31F127F6-A096-4991-9D4C-1B2E032689A1@gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 1 Sep 2022 08:55:41 -0400
Message-ID: <CAKf6xpvZNHQyQq9zqNpD0kXFK+pryAKKbRDxoiMkB=PrhvSGKQ@mail.gmail.com>
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
To:     Rich Persaud <persaur@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 10:35 PM Rich Persaud <persaur@gmail.com> wrote:
>
> On Aug 29, 2022, at 11:16 AM, Jason Andryuk <jandryuk@gmail.com> wrote:
> >
> > =EF=BB=BFAn HVM guest with linux stubdom and 2 PCI devices failed to st=
art as
> > libxl timed out waiting for the PCI devices to be added.  It happens
> > intermittently but with some regularity.  libxl wrote the two xenstore
> > entries for the devices, but then timed out waiting for backend state 4
> > (Connected) - the state stayed at 7 (Reconfiguring).  (PCI passthrough
> > to an HVM with stubdomain is PV passthrough to the stubdomain and then
> > HVM passthrough with the QEMU inside the stubdomain.)
> >
> > The stubdom kernel never printed "pcifront pci-0: Installing PCI
> > frontend", so it seems to have missed state 4 which would have
> > called pcifront_try_connect -> pcifront_connect_and_init_dma
>
> Is there a state machine doc/flowchart for LibXL and Xen PCI device passt=
hrough to Linux? This would be a valuable addition to Xen's developer docs,=
 even as a whiteboard photo in this thread.

I am not aware of one.

-Jason
