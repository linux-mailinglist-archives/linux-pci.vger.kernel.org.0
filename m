Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93192503651
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiDPL2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiDPL2m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 07:28:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C663E0D4
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 04:26:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k29so10587103pgm.12
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6vYx3JbvVsiL3zhGAbJQC+kPjCGgnDC5DdXmocu9kt0=;
        b=FtctIQ0FnMDY9bdwWMRWq1bfsMqzeBrjYtMrHQB8F4oW+igs18W/0mSpbn9YULSEuT
         Gh0Dqu9j3kGm1xPjk+ySe4Imgw1DFdo4PlsrR2qOoD5aWUZLTvIchJf/knqArageNINB
         l2ugpGMK4sm8XD0tjnQEyYXv4SvcWZadFP7f4Fuj4vnM3W5FAXNUIabPRMiolgscl2sm
         WLuX1dV4fG/EpLDiUF7RlYd9fMgpGEvhLHmvTAZcPw25hR0hPthoELCPVCpI9Lf5V6nl
         uIGkFnTiIo25MZkabNl2zIhCcS3PU3HY2HiVD5LwQFDHMQvutBg3UWREHaUtktORYOuf
         Jv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=6vYx3JbvVsiL3zhGAbJQC+kPjCGgnDC5DdXmocu9kt0=;
        b=pUHWH8ZoKLJ6ika8tEik5AugL7BG9bFfo1TutNHgZ8M1QyFce4ILGwzKfmlU2/dyCw
         +uk2q1vc3WXw4rZ4gOOIlI9WOY2cIVZQmJs1heol4okzfmQSWkqUyc4sX67MCevGPd/a
         z1aOwvyuDhLFAME1QC9hQOJreArgZiJXHsvpw7Wk/wQj2xFaNQZSBltTnK4I5CgzobHb
         oaEzkdQC6c6Vg4bPbzTlCMonRVc/zIggacfwLOZn+4S3JnIZs6Dm7OYpyGoKxogCeH9G
         R3CQZ2QexcsIgDMN6LIV7PHJKjkinHo8aZMkqDRG9+0WCbEPaic4YLgClQml82vQwORG
         iDyg==
X-Gm-Message-State: AOAM532VsMKjMjBQTepQeZC3YBcwYDfLMMcjRBmofq6kpQf6pBXsHJ2f
        IZezVbOgUDPVxtY3F7OAJseUXIVKEL/3mv/sVFk=
X-Google-Smtp-Source: ABdhPJyn7EYzzxA1fhTDUCNVJ7A06l/t0Cv7eu6yMckv/jH5uPqfH+ABA7ocEcdWI46AZr670OK/jiu1hpkBV/7v7w4=
X-Received: by 2002:a65:4947:0:b0:3a4:dd71:be90 with SMTP id
 q7-20020a654947000000b003a4dd71be90mr1726416pgs.449.1650108371107; Sat, 16
 Apr 2022 04:26:11 -0700 (PDT)
MIME-Version: 1.0
Sender: barrlucasnubueke2@gmail.com
Received: by 2002:a05:6a10:43d5:0:0:0:0 with HTTP; Sat, 16 Apr 2022 04:26:10
 -0700 (PDT)
From:   "MR. EDWARD" <edward.esqchambers@gmail.com>
Date:   Sat, 16 Apr 2022 12:26:10 +0100
X-Google-Sender-Auth: kwbD4rQ31p3N664-3G6naOipKCY
Message-ID: <CAHcyid9GV0-=zHcyOujncQ-9eeKk7+OOtH5F6R+offecwWHidg@mail.gmail.com>
Subject: =?UTF-8?B?VsOhxb5lbsO9IHDFmcOtamVtY2kh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Zdrav=C3=ADm V=C3=A1s, kone=C4=8Dn=C4=9B z=C3=ADsk=C3=A1m d=C4=9Bdick=C3=BD=
 fond s pomoc=C3=AD nov=C3=A9ho partnera.
Mezit=C3=ADm nemohu zapomenout na va=C5=A1e minul=C3=A9 =C3=BAsil=C3=AD, ab=
yste mi pomohli
z=C3=ADskat fond, a=C4=8Dkoli jsme v minulosti neusp=C4=9Bli kv=C5=AFli ned=
ostatku d=C5=AFv=C4=9Bry
mezi n=C3=A1mi. Nyn=C3=AD chci, abyste nal=C3=A9hav=C4=9B kontaktoval m=C3=
=A9ho ctihodn=C3=A9ho otce
Solomona na jeho e-mailov=C3=A9 adrese ( rev.christlovesolomon@gmail.com )
Nechal jsem mu v p=C3=A9=C4=8Di o v=C3=A1s =C4=8D=C3=A1stku 800 000 $, tak=
=C5=BEe ho kontaktujte a
dejte mu pokyn, aby v=C3=A1m p=C5=99evedl celou =C4=8D=C3=A1stku.

Pane Edwarde
