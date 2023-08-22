Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F97847D4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjHVQiE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjHVQiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 12:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5789184
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692722240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnGdXfhYpeYSemU19xhB8UMjBrCGspmXkJpZEmSbZjM=;
        b=epWEZhn92Ub8WGEgP/3k7iEceTqr5JX5EQ/tfShTDBtUIX7RhnIwFWOWvV3j928VNvR7Nr
        7lIR4r1h5AiN32pkZm3GRIaUOLZ7dVIbs9ufYwwj16RuB5y0gpBvDyNtNDDZsdbmM2/A21
        4XB/hKdDhCbVxkU5S6tfVIi+ulr0XeU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-DOoNHf4mNGSHLPw4XESX6w-1; Tue, 22 Aug 2023 12:37:18 -0400
X-MC-Unique: DOoNHf4mNGSHLPw4XESX6w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-267f00f6876so5155948a91.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 09:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722237; x=1693327037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnGdXfhYpeYSemU19xhB8UMjBrCGspmXkJpZEmSbZjM=;
        b=R5Wd9UReTQ6t+fwkhL0jERL9FQubSazNuGzp93tSQXEXFZciakU0DbT3LQ+fRX9SGD
         Vv+QbIOvALIntnN7PcG6aAlDdS6lo2wV5z5NoKB1Gulh+0Kf34sdAihicKbR5GueJ1GP
         2xKaL87uzjmfERiMfU/gHDPgpi0JpB30KnwYkhvRYkuhfM+y6KQhxXX470N8mtWUp1ie
         rBj56C0QuSXKVYsKNNmOPq0urk7ncWEVJr7OpSk2Q8ieCjE0L8Hpmsd/YZzDwrMJCKCo
         wCbBYl65sBi2uT6+Y0TbQ5M90bAIWXwoczulvoPModOL558nXCPIcctSIKf9RDYfC0aQ
         WdeA==
X-Gm-Message-State: AOJu0YywY5n9a4SQTJP/KDdtu3NEo+e2GzPH2wMHRcc27Hmc0+rZJTX2
        cYKLs72PeROOiuw/Bi5Rv5fhwHJP6S019h0DZHfbEr5T2cD4exEz55eHJFKLHnEvs+GF7gSmjwD
        M9fS+pwK2r5jwx3Wh+qlkf7beRt7wMk0iz9k=
X-Received: by 2002:a17:90a:6bc2:b0:269:5adb:993 with SMTP id w60-20020a17090a6bc200b002695adb0993mr6518744pjj.22.1692722237552;
        Tue, 22 Aug 2023 09:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKrBspwI7hWFcRVdnctcIzftV6xUGBzXsFOt81Kbgvk/KkCkDNG8gw4FZ7HQ3q4DafK7fwpPZsU7HhpPwhAHs=
X-Received: by 2002:a17:90a:6bc2:b0:269:5adb:993 with SMTP id
 w60-20020a17090a6bc200b002695adb0993mr6518726pjj.22.1692722237206; Tue, 22
 Aug 2023 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821191055.GA362994@bhelgaas>
In-Reply-To: <20230821191055.GA362994@bhelgaas>
From:   Kamil Paral <kparal@redhat.com>
Date:   Tue, 22 Aug 2023 18:36:50 +0200
Message-ID: <CA+cBOTfRbok8D+J-SuxWYoDbJT_uOG6CJ4Y4rqvYNAjq5G-Mvw@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        mika.westerberg@linux.intel.com, bhelgaas@google.com,
        chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 21, 2023 at 9:20=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> Wow, this is super interesting.  e8b908146d44 literally just increases
> a timeout; the complete patch is:
>
>    static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>    {
>   -       pci_bridge_wait_for_secondary_bus(pci_dev, "resume", PCI_RESET_=
WAIT);
>   +       pci_bridge_wait_for_secondary_bus(pci_dev, "resume",
>   +                                         PCIE_RESET_READY_POLL_MS);
>
> Increasing a timeout should never cause a failure like this, so
> there must be something really unexpected going on.

Hello Bjorn, thanks for a quick response.

Your reply helped me discover that the laptop doesn't really *fail* to
resume, it just makes the resume much *longer*. I just never waited
that long. PCI_RESET_WAIT is 1 second, PCIE_RESET_READY_POLL_MS is 60
seconds. If I wait long enough, the laptop finally resumes correctly
after roughly 70 seconds (before the patch the resume took roughly 5
seconds). Sorry for not spotting that earlier!

I also tested this with the current git master tip (commit
f7757129e3de). Without any adjustments, the resume delay is roughly 70
seconds. But if I change PCIE_RESET_READY_POLL_MS from 60 seconds to 2
seconds and recompile it, the resume delay is roughly 6 seconds.

With the latest kernel f7757129e3de, here are some debugging logs:
* dmesg collected after delayed resume (extra 60 seconds):
  https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984636
* system journal after delayed resume:
  https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984637
* lspci -vv before suspend:
  https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984638
* lspci -vv after delayed resume:
  https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984639


> Would you mind
> collecting the output of "sudo lspci -vv" both with and without
> "pcie_aspm=3Doff"?  No need to try suspend/resume to collect these.
>
> Also, what does this race condition look like?  Dock devices are
> visible before suspend, but sometimes none of them are visible *after*
> resume?  We don't re-enumerate on resume, so does this mean they still
> appear in lspci output but they just don't work?

I didn't manage to debug this today. Given the newly discovered
circumstances described above, I wonder whether your request still
applies. If it does, I can provide it tomorrow.

Thanks for looking into this,
Kamil P=C3=A1ral

