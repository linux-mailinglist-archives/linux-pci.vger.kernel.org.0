Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02087B7025
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJCRoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJCRn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 13:43:59 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846DAC
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 10:43:55 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3122D3F63B
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696355034;
        bh=RekqBXxIuo8nUJ1wOD8QPazynzzYmeoIKII5+diCjtM=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=b/jFWKo9XX2cCl+X70MC493XMTU4UVwVY3Ur0Cr/9x5i6hFBHjH2dfQNAS3nAP+IS
         Igx5lTabdpGjWnWmq6b69y04XpVLlCFmuMbQY06CFGAXQX/ugoR2Y47duVJNRtNLc0
         Y1t8ZzQJUcAPAqhmwweXSw9Wlo+uiHXaLFmJ1aYki/5XnPcv1MrEnaK92Xrrd1+wIZ
         z/DEKL7JxW7rq26OdlNza0130VoRFCY2N0ESOtPQMEvyiFTxWY5J52lD9vgataUvqD
         JxvnamshxzP1PxxgZfqAR6csHBmc1qyDIstaCmVncxrZ1l6eJbAqf54sCRLWR05yY9
         MGkq+BWcnImbg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27733adfb12so39382a91.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Oct 2023 10:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355032; x=1696959832;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RekqBXxIuo8nUJ1wOD8QPazynzzYmeoIKII5+diCjtM=;
        b=m8jJanNBLHL7JAFIbOaP4sCPEaQ2SYD1xny5+97t3KJhq03S4aECMftXCipNsU42Nb
         WM6jI5nyf09h81j0GfSyVpVo7jY9nUyeI/oJjo8WEV1n3DX4BKuWlOjzVt2N0F3iUgGd
         7gZiwBah+y5k/0VKgCCfYX93rIrmhUKc1w8tFDBKhfPk7iLUlvyEMz2CO9kLid3R4ETN
         AGsb6tymbNzmLC/zpW8Hgg7+A3uXqZclM8C+JiTDcdbXPD5JvyIzG0TUdQ3XmwIKIURp
         qQH+qTdP+rNuOjuQ7ow47+Xx0yDUCOVjV1BgiIu5T1GpJy5YXVlGoLXLMyaLx4Ha8pMw
         0hVA==
X-Gm-Message-State: AOJu0YxL9ZljYFeZALl4fV3ho3L9PNs4g0kljThQWQ4cLO9/G8nggan7
        g5sUgOyISX2zs8WUKAO7tnqavUqh7DV3BWLq2zjA0m/TwOXt7KIcl4+4DlKv1WSssSvuT7MU8Qs
        Ga6Ph78BMKkFZWOcujQ9nMt5meYYfEIPpKmzR/A==
X-Received: by 2002:a17:90a:6b08:b0:277:422d:3a0f with SMTP id v8-20020a17090a6b0800b00277422d3a0fmr5126857pjj.17.1696355032656;
        Tue, 03 Oct 2023 10:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf+mJNCF8GOIgzfEETYZUhbEzNCAt0tEO+UwMr96ToEKnZHXBX0JVvdaGx2aQGr46KMJUqHA==
X-Received: by 2002:a17:90a:6b08:b0:277:422d:3a0f with SMTP id v8-20020a17090a6b0800b00277422d3a0fmr5126815pjj.17.1696355032293;
        Tue, 03 Oct 2023 10:43:52 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a001300b00279951c719fsm2043254pja.35.2023.10.03.10.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:43:51 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 661365FEAC; Tue,  3 Oct 2023 10:43:51 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 5DCC59FAAE;
        Tue,  3 Oct 2023 10:43:51 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
cc:     intel-wired-lan@lists.osuosl.org, linux-pci@vger.kernel.org,
        pmenzel@molgen.mpg.de, netdev@vger.kernel.org, jkc@redhat.com,
        "Vishal Agrawal" <vagrawal@redhat.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: reset first in crash dump kernels
In-reply-to: <d0dc80a2-6958-5cc1-b75e-2f1dd513f826@intel.com>
References: <20231002200232.3682771-1-jesse.brandeburg@intel.com> <17923.1696290586@famine> <d0dc80a2-6958-5cc1-b75e-2f1dd513f826@intel.com>
Comments: In-reply-to Jesse Brandeburg <jesse.brandeburg@intel.com>
   message dated "Mon, 02 Oct 2023 22:50:27 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <789.1696355031.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 03 Oct 2023 10:43:51 -0700
Message-ID: <791.1696355031@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

>On 10/2/2023 4:49 PM, Jay Vosburgh wrote:
>> Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:
>> =

>>> When the system boots into the crash dump kernel after a panic, the ic=
e
>>> networking device may still have pending transactions that can cause e=
rrors
>>> or machine checks when the device is re-enabled. This can prevent the =
crash
>>> dump kernel from loading the driver or collecting the crash data.
>>>
>>> To avoid this issue, perform a function level reset (FLR) on the ice d=
evice
>>> via PCIe config space before enabling it on the crash kernel. This wil=
l
>>> clear any outstanding transactions and stop all queues and interrupts.
>>> Restore the config space after the FLR, otherwise it was found in test=
ing
>>> that the driver wouldn't load successfully.
>> =

>> 	How does this differ from ading "reset_devices" to the crash
>> kernel command line, per Documentation/admin-guide/kdump/kdump.rst?
>> =

>> 	-J
>> =

>
>Hi Jay, thanks for the question.
>
>That parameter is new to me, and upon looking into the parameter, it
>doesn't seem well documented. It also seems to only be used by storage
>controllers, and would basically result in the same code I already have.
>I suspect since it's a driver opt-in to the parameter, the difference
>would be 1) requiring the user to give the reset_devices parameter on
>the kdump kernel line (which is a big "if") and 2) less readable code
>than the current which does:
>
>if (is_kdump_kernel())
>...
>
>and the reset_devices way would be:
>
>if (reset_devices)
>...
>
>There are several other examples in the networking tree using the method
>I ended up with in this change. I'd argue the preferred way in the
>networking tree is to use is_kdump_kernel(), which I like better because
>it doesn't require user input and shouldn't have any bad side effects
>from doing an extra reset in kdump.
>
>Also, this issue has already been tested to be fixed by this patch.
>
>I'd prefer to keep the patch as is, if that's ok with you.

	Thanks for the explanation; I was wondering if this methodology
would conflict or compete with reset_devices in some way, or if there's
a risk that the FLR would in some cases make things worse.

	Since many device drivers have this sort of logic in them, would
it make sense to put this in the PCI core somewhere to FLR at probe time
if is_kdump_kernel()?  The manifestation of the issue that I'm familiar
with is that DMA requests from the device arrive after the IOMMU DMA
remapping tables have been reset during kexec, leading to failures.

	Regardless, the patch looks fine to me given the current state
of kdump / kexec / reset_devices.

Reviewed-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
