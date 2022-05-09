Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E65202CE
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiEIQsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiEIQsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 12:48:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2E403DC
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 09:44:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m190so14470838ybf.4
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2022 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FLdZEfi1SiuPyRsGjAUYifHwyV1TrdUbmSs9fazigkQ=;
        b=n8ObLobxiIiXxDFmx2oKoiY00N2561ROuWlDzZBZW/3eK8Kvw5C+OouLYhaAQluk6X
         LUBJFzU+xDSK2YpQrQihLDafCWwdQdKGKMtp5Zq1r/LI+79cdtiQ2g0U0+IcsnZkMIAW
         KsG4sagOYrorHMe/nzXe9cnRAWdGh8bAwd1PgIjDf5ABOln4UH74v3cNWmbsW0xayxn6
         KEq/AqnnSqjKRgudtiRw7FA/7gazzNXYSPHiFY7jNIXcohIMrnkasiTD5OmZ+wKLEyrJ
         SeSC7+CiDMOk1LVAksKRTs/INcOCRKYp7ibM9k6l6Qc/n1O43hSWhyVsWrrpKm9dfkGS
         6FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FLdZEfi1SiuPyRsGjAUYifHwyV1TrdUbmSs9fazigkQ=;
        b=cEl9XXptjT0FizFVh5WVdU9ZUeZwbtlrBL4V7FBaDFR0Cn0CdOEbRC+MfXM1/JNOkH
         IKt4HXfSoXCw2zVmLlWtWOJcVam0sAZU7evlqTluQdvD8AtzR20gYkEY4FRukKTpw8M7
         LxAXekmbNVFlM9fV80tzDrC+7+raZ7OFT9jb5NWW+AO1eR/jkZeDSbDnJsRsur0TCuq7
         joiCnetGpbN85vuz+00EvFfiQbbT8q/vhfq1oMTUlCvDTaA8RMe7Hv8uEnD/riCRiSnB
         XvTa6Fk7pvIoYUE20twFBr3ETm5JNCTFRcvBaKFVTKxXewCMIBZRrPhKrzyAR/kvt5d2
         sV0A==
X-Gm-Message-State: AOAM5334/3QXxJU0xv4qwXaT7C+kDV58OcM0nwMYo5dp9T15TzsydYr6
        XJsq/ao4Ty2QrgDoomLizNjSwrv750S3Piz1pQfxFGRNNHU=
X-Google-Smtp-Source: ABdhPJwJweATsp5cK7UaoVqW/H096izite3HMl93P4YBNC3sm/nNrZzaLRFfRAvYRFesc1i0KehoMJ7ELPV41xpKDfs=
X-Received: by 2002:a25:2554:0:b0:646:afdc:636b with SMTP id
 l81-20020a252554000000b00646afdc636bmr14836659ybl.15.1652114675592; Mon, 09
 May 2022 09:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <159256437449.6259.16730569084807322246.malonedeb@soybean.canonical.com>
 <165111854824.1494.8338100988705781174.malone@gac.canonical.com>
In-Reply-To: <165111854824.1494.8338100988705781174.malone@gac.canonical.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 9 May 2022 11:44:23 -0500
Message-ID: <CABhMZUXkZPjqGZBb+Yk8bf7UhG1jcctLnhwgNSB+AJy8kYhqMQ@mail.gmail.com>
Subject: Re: [Bug 1884232] Re: touchpad and touchscreen doesn't work at all on
 ACER Spin 5 (SP513-54N)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

_CRS issue on ACER Spin 5 (SP513-54N).  Not sure if it's related to
the E820 thing or not, Hans.

On Wed, Apr 27, 2022 at 11:10 PM Moataz <1884232@bugs.launchpad.net> wrote:
>
> This workaround is no longer working when upgraded to 22.04. I have
> added all the details on ask ubuntu and ubuntu forums:
>
> https://askubuntu.com/questions/1402796/touch-pad-and-touch-screen-are-
> not-working-after-upgrading-to-ubuntu-22-04
>
> https://ubuntuforums.org/showthread.php?t=2474206&p=14092022#post14092022
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1884232
>
> Title:
>   touchpad and touchscreen doesn't work at all on ACER Spin 5
>   (SP513-54N)
