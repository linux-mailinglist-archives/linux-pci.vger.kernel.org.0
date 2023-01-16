Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5518366CF0A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAPSnq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 13:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjAPSnV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 13:43:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A914EAD
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 10:37:34 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n5so30337903ljc.9
        for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2023 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmmqAlXHR2xQyXICKdDTulByjwB2PGtUrEuz/sYCWck=;
        b=iCvtkQfiaZxI8paqQYWRUyT1E3UsfRPRrUSBoOINwE2p7NUzTs6UWp4Bo7LwVPDIHF
         QJSjpPfqxMm+R9ijNtzW4gZXP31098QPlUckpiv00S7xNZho6s5vZg85y/nfxilEQy8B
         RqIJHX9VZTLfR1ckskm5K3DNZInRGUJfBxVe4zHqSVL+r65GmTysbDLD7WAhRPrwoMGH
         xQOSDy2yOCkYbBWKdAdUqRb906uDnkFCEv1Dda/fNqV/UN3RVoTQQmqvOFi6mOgAn70o
         EhdDHdyr5BnTwwtupLbxpwbVnkt7RTaf9OJZSuAsDnHAb80U0VEHvjx2ZguJm4TepkDs
         tbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmmqAlXHR2xQyXICKdDTulByjwB2PGtUrEuz/sYCWck=;
        b=h2VvQSq5vWpYjYPvgVmHuue1QCLIeYpHOEiP5UjBU7j+y+AKWrT++m4bTNX+Ocfr0I
         blG2VLbXBnpY8cf1T0UADFq+c5jfEwMd9ZwLLafhmtlB0gvoWD5Kh78GEOY7bp7FFj2v
         gXtup/dbNoAzZbJvylRb91RZhHBN/b4rKzqc5+s2UqYqvoK+6V6x6Dj44k+6ijdzCnif
         nLXr3ODSVUCxm3K0/I4FHSayQAzotYTv0uy/SJDtQF+9NM3fHYvm0h4erK/t6ap6iegR
         J3RjTSwBf6vq1MYbazKlxlWJclHqxYtXkaM077dEcKtslRmZRf84dtVYwtYAm7YZFcUR
         UQZQ==
X-Gm-Message-State: AFqh2krMYSKeTc4EnSo9W7OWkllxlI9NxpuSFPrI+WAq3LMoxxILvSvP
        Qqx27JdrjZVQYE4baNwu7pR4G8bl49rEV+7yh14=
X-Google-Smtp-Source: AMrXdXtT8hlt81ZtzvOtgu1lIGl6FSSExlHughEn2xYo07dHgFC2nyjkoNb0pJejkHzkkexdk/NvggSgrlGilf5ZxYQ=
X-Received: by 2002:a2e:8617:0:b0:28b:87fc:ffae with SMTP id
 a23-20020a2e8617000000b0028b87fcffaemr46584lji.127.1673894252435; Mon, 16 Jan
 2023 10:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20230105191852.GA1162145@bhelgaas> <5b9a2dc7-54ab-82c5-81e7-1770a4ec891c@amd.com>
In-Reply-To: <5b9a2dc7-54ab-82c5-81e7-1770a4ec891c@amd.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 16 Jan 2023 12:37:21 -0600
Message-ID: <CABhMZUWgt9Ut6hWXNGiD3giW5UYVp-+hCipNvmPwPUdsHCE1Rg@mail.gmail.com>
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
To:     Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
        Alexander.Deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 16, 2023 at 9:24 AM Anatoli Antonovitch
<anatoli.antonovitch@amd.com> wrote:
>
> Thanks Bjorn,
>
> The extensive testing has been done for hot-plug, hot-unplug the device and ACPI S3 suspend/resume cycles on system with AER enabled.
>
> The patch has bee resent.

Thanks.  Just FYI, the mailing lists generally reject HTML email, so
your response doesn't appear in the archives:
https://lore.kernel.org/linux-pci/20230105184355.9829-1-a.antonovitch@gmail.com/

See http://vger.kernel.org/majordomo-info.html,
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style,
https://people.kernel.org/tglx/notes-about-netiquette .

Not a big deal for this response, but it is important for more
substantive conversations.

> On 2023-01-05 14:18, Bjorn Helgaas wrote:
>
> On Thu, Jan 05, 2023 at 01:43:55PM -0500, Anatoli Antonovitch wrote:
>
> From: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
>
> It is to avoid any potential issues when S3 resume but at the same time we want to hot-unplug.
> Need to do some more testing to see if it is still necessary.
>
> I'm not sure how to interpret this.
>
> I guess I'll wait for you to do the testing and repost this if it does
> turn out to be necessary?
>
> I don't want to merge a patch with a commit log that says "need to do
> more testing."
>
> Bjorn
