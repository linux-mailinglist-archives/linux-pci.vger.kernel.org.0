Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9182B5A8B81
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 04:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiIACfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIACfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 22:35:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020F45721D;
        Wed, 31 Aug 2022 19:35:09 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j6so12274144qkl.10;
        Wed, 31 Aug 2022 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc;
        bh=HvAnqh6oLQZyoeHCbOzg6Bi01dtZi6A0ssMqdIvSvXw=;
        b=MNEBo+Zsxwbetrquwiayil07AvrTnYMSCBrvmU38nzsham4ud4J34GIxLB4AjenhSC
         Ma2cGOmU6aWBguXvPY+e12cpy/e87kfuTb16KBtDJ+Yd1HxdDfObYhSKYmrB3dp7f1O4
         DrGn5t9GIykC+JrHFu9bYJj5LtY0VW3LFe2G8c4gI3joQnR/PRft8687VHVSNyA0sTU7
         RzEzuhuolx2LnhbHDg7QfJ8faMDn1x0erS3MSWTHHt85y8VAGTFbAg/5W9fBFGGuygbZ
         n+udgfyQjwInwZhukqZn52WGg042RJqwZ+cjh1YQfyv/MolyeY37Ns/z/adUB4lKtseD
         YoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc;
        bh=HvAnqh6oLQZyoeHCbOzg6Bi01dtZi6A0ssMqdIvSvXw=;
        b=oMRTvFiV4XAXdFIpy5SepKRaz5Uq6RriFr9qer2tGnKDjJM3H6avzL0Akk0Q/xSs1F
         H7TOVFR2d+pbDZrX9grPYpvrcSa9m49J+ztVVd9sJ0exbl8WS8L75cN2a07iBejJh2+h
         CjAI8COKBmc1v3PiiuGDVDoLZQEZVV/YAeY583ZNS5QBwlU0GEO/7JSvvnIyExSf+lF9
         BbuyRun1CHosyPqNdwGsIzh1ihKdJ7ujLeBB9gG1fjkhaFWUEn65qKxpvzjOcSDHXF9f
         DCLrJn+XwQmyY0HXRiFcvbvSkglDawFMyJ8rjoORndufGa0hiVahtrvGPz0lm6780Gt+
         gQmQ==
X-Gm-Message-State: ACgBeo13FjPe4nzViXMqrC3On3aqi1z288/jBYzHpdiqh78AQcszgyOy
        DvzF9cdI8C1UQaZh0KhWH5k=
X-Google-Smtp-Source: AA6agR6KXYuUK62Dl1PGX+4IdTEpnv41poGFatJelFOad0HJkABM+PVXqMsd/jk/2Udq60jOOoRkNQ==
X-Received: by 2002:a37:a84e:0:b0:6bb:bf0a:5be7 with SMTP id r75-20020a37a84e000000b006bbbf0a5be7mr17080767qke.213.1661999708126;
        Wed, 31 Aug 2022 19:35:08 -0700 (PDT)
Received: from smtpclient.apple ([87.249.134.31])
        by smtp.gmail.com with ESMTPSA id k17-20020a05620a143100b006bb83e2e65fsm10502390qkj.42.2022.08.31.19.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 19:35:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Rich Persaud <persaur@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
Date:   Wed, 31 Aug 2022 22:35:06 -0400
Message-Id: <31F127F6-A096-4991-9D4C-1B2E032689A1@gmail.com>
References: <20220829151536.8578-1-jandryuk@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829151536.8578-1-jandryuk@gmail.com>
To:     Jason Andryuk <jandryuk@gmail.com>
X-Mailer: iPad Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Aug 29, 2022, at 11:16 AM, Jason Andryuk <jandryuk@gmail.com> wrote:
>=20
> =EF=BB=BFAn HVM guest with linux stubdom and 2 PCI devices failed to start=
 as
> libxl timed out waiting for the PCI devices to be added.  It happens
> intermittently but with some regularity.  libxl wrote the two xenstore
> entries for the devices, but then timed out waiting for backend state 4
> (Connected) - the state stayed at 7 (Reconfiguring).  (PCI passthrough
> to an HVM with stubdomain is PV passthrough to the stubdomain and then
> HVM passthrough with the QEMU inside the stubdomain.)
>=20
> The stubdom kernel never printed "pcifront pci-0: Installing PCI
> frontend", so it seems to have missed state 4 which would have
> called pcifront_try_connect -> pcifront_connect_and_init_dma

Is there a state machine doc/flowchart for LibXL and Xen PCI device passthro=
ugh to Linux? This would be a valuable addition to Xen's developer docs, eve=
n as a whiteboard photo in this thread.

Rich=
