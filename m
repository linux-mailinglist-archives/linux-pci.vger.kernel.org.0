Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E096487E16
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiAGVRT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76BC061574;
        Fri,  7 Jan 2022 13:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695E061F70;
        Fri,  7 Jan 2022 21:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ADCC36AE9;
        Fri,  7 Jan 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641590237;
        bh=ZyZSNdTdYKDM/PM4czKKe1vtoHFBDRhI//cIwqYKF/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Guf5MgoNmqZVbW9SsYLmr1v1Iu00vtR9xSjSzecdPjOlKwZy3GLZaHuqbAxSK1IsH
         aLVvHr4b/pX8HdkxsLfCLlvbKEOKOKx3c8Tzym1zZCktZLlvFlwuIJ9s5EgBkWlqVO
         iQSZaR9tmTfKkO+v3jnTk5pmC4rNLFr1RgT7+Q97TOZVHANnuNcYSBeoLCK81JpZ3X
         1Z9PvmJsuQzxEYTvxqMo3o5r0NCi91riEQNzlHTdeYtHBNwiBari0zA+f5iNWuvCE+
         PLeBkIPprmk5KSTzX1H6/SfB9tU3iNywgA9SgvxzFNhsNqA1u7kIp+GfNVRQbp0fc3
         YqqzVp8AlZ67A==
Received: by mail-ed1-f42.google.com with SMTP id w16so26728015edc.11;
        Fri, 07 Jan 2022 13:17:17 -0800 (PST)
X-Gm-Message-State: AOAM532/yv3mGOPQMmavtt488cxtI6J4XZAVqZM+xEVRZcc0v/UTOP8W
        TyTHgTSCvtXeBdUV/Xjrc4AhItlX01zBwaXIxA==
X-Google-Smtp-Source: ABdhPJwhYP5L/D5FuTkCnrVBldJqIANuw983olD+mNWb51nUUcGUNWnQvmyrduk/ct0surZiW4Rgp7Q32BATVQ9MloQ=
X-Received: by 2002:a17:906:5284:: with SMTP id c4mr50734997ejm.423.1641590236121;
 Fri, 07 Jan 2022 13:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20211031150706.27873-1-kabel@kernel.org> <20211031150706.27873-2-kabel@kernel.org>
In-Reply-To: <20211031150706.27873-2-kabel@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 7 Jan 2022 15:17:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJkY3CPYUm3cXgnJJXVbOyxnd4fkkqLdH287sZ+nTJLNQ@mail.gmail.com>
Message-ID: <CAL_JsqJkY3CPYUm3cXgnJJXVbOyxnd4fkkqLdH287sZ+nTJLNQ@mail.gmail.com>
Subject: Re: [PATCH dt + pci 2/2] PCI: Add function for parsing
 `slot-power-limit-milliwatt` DT property
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 31, 2021 at 10:07 AM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> From: Pali Roh=C3=A1r <pali@kernel.org>
>
> Add function of_pci_get_slot_power_limit(), which parses the
> `slot-power-limit-milliwatt` DT property, returning the value in
> milliwatts and in format ready for the PCIe Slot Capabilities Register.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
>  drivers/pci/of.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h | 15 +++++++++++
>  2 files changed, 79 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
