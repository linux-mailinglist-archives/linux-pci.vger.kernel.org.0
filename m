Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E66E8CC1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjDTIaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjDTIaE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 04:30:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB13A9B;
        Thu, 20 Apr 2023 01:30:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so479173a12.3;
        Thu, 20 Apr 2023 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681979402; x=1684571402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8l1ESpXHxzWLDIQttyzXAT7xTcWnUV7eDyg/ABvMSg=;
        b=XOcAL4aDdC2u68CIkflKY8VEZOUAjFbXs6A6WqAN0Oo10Vx7bKR4N9OQoQP8lL9PtZ
         wGtLiSfDuxdoJzMOCIpK4eQdcllYioasJpRJ5J34lisGJ77sIKTW3nuAKJnqa3bhpr6m
         UAgQFUKNFsBFziNEBwDg18Yo2xGbxS+NynivjAeT+EfkpCSg76WQabe1WX3XZ1R9px9i
         PSPRri3YoMWzF19HXAmf3xdPWrhCvOhuzjp/0JNSoONbEiEQ8vg8h8Ou+QE4c3CwzyT0
         udobragF/oD+b2YbC/sU3s9AzT03TDE7Xc/Y4LKJNuvlf6wZ8naUwXRa3H7yyl7MEyzv
         oY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681979402; x=1684571402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8l1ESpXHxzWLDIQttyzXAT7xTcWnUV7eDyg/ABvMSg=;
        b=GBNsQwuafodr1LysX5SD3j3mLssTvG38MXfaaNYcrrYOL+oC3hz2tvltzq4s4lfLS+
         rovgABzCfboet3ThvjpK5lS454x5yhbL/SudCAKx5J4POvhDes0qHSIxrhhL4zsa//4f
         pVu7dz2jLFTE8zDPWivsqgMRP7D+XaPplphFF9Ajml1ZP8Pg4xHKKlVgw7G7lLuPr7dB
         OSWIIzolQca5PEYOIumdltylPX7dnBPSrTE9xh/EbcyWAoUfVRxBKcvEbZouKg+s9c6L
         ZalFcf015Gl6y/xZjLzmAOYgnSziEtSSDlUf+OmaRVavbIYyMaCXr5upvgZjAlZekVe4
         MCpg==
X-Gm-Message-State: AAQBX9e6Tg7sdntTwjSbCuB5LYFLymTK4mKML8bRuu3eG+Oa8VtmJ8jy
        lm7Dn36OE3ySaQTFPxFHRuBrDsBbcQ/9lsm03s8=
X-Google-Smtp-Source: AKy350a/UjaNyE1AjOgaiqC2g5z5b2nZx4OrJ73HPTdbLy6SiS7WHEbqRUVMPSV/elItzBZW1lHhqeqjwCaDfYHARUs=
X-Received: by 2002:a17:90b:17c2:b0:247:6be6:7ba3 with SMTP id
 me2-20020a17090b17c200b002476be67ba3mr1023996pjb.32.1681979401854; Thu, 20
 Apr 2023 01:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230420081957.1440423-1-korantwork@gmail.com> <3b711d73-ac46-7a37-e835-f9dadeb96dd3@kernel.org>
In-Reply-To: <3b711d73-ac46-7a37-e835-f9dadeb96dd3@kernel.org>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Thu, 20 Apr 2023 16:31:14 +0800
Message-ID: <CAEm4hYUbv8C6Ucf_zJVp+wXZwHTW9EcnH-5JwzgdgXQmtGoGzQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Fix two issues reported by Smatch
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
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

On Thu, Apr 20, 2023 at 4:23=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> > And one inconsistent indenting warning:
> > "drivers/pci/controller/vmd.c:1058 vmd_resume()
> > warn: inconsistent indenting"
> >
> > Fix it by formating its indenting.
>
> But this is cosmetic and does not need backporting/fixes tag in my opinio=
n. So
> better split this into 2 different patches.
>
Got it.
I will split it.

Thanks~
