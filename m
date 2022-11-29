Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7963C4E4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiK2QOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 11:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiK2QOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 11:14:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42387697E5
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669738374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj68G4xSImQmb9mtsWIYEi9SMG5gP67LQoaMPXTNKlc=;
        b=Cwo+pJfamQKGa4ICRRr5CdE9WoP1XvaybyWhhrgajKNr2nPmsKTePhQQlrqo4zvv4Zwpmb
        Pu+M5vBb3akBg+u1x4gT418mRiD1t09FJM7CEU8ZpAu8n2tPyCqruO0n7JZrWW28+59ahz
        ZLXoma4F7Q3grYCkn5xZdpgVy9DpCFo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-qNtEUENlO9y2Stes04BwBw-1; Tue, 29 Nov 2022 11:12:52 -0500
X-MC-Unique: qNtEUENlO9y2Stes04BwBw-1
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso12568165ili.21
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 08:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj68G4xSImQmb9mtsWIYEi9SMG5gP67LQoaMPXTNKlc=;
        b=3lK4Dbe9YhkZzqZMufqC9YIqFmQ7GxqZ48V8menRjGV7imQCB7q1/q/2h/+wFCd7s0
         cGi81lSF+yfxbVFcttgl5vNfwz/vyjUPDzlPL1qsG6kZxYGsmQUYhjZ/OU5WlwT8dxIa
         Ms59dcCaJune5QzeAZcX0pBT7tcruLulS3bqI0vJwnnTeg1u/fNsWxmovSqQJZfd/ykj
         EmvkGSt4QPXGTdZe5wf0o8icHT1XIplM2TX0nWCLP0ay4YcIvkkCxuCdqsmNARZooZxi
         R+PtL2YTvWY4zQ4OK0Y8EznBVWX42g/Ue617Y4DU4KeIRIYaIV/10hFF+u1Xlh8+2kR3
         /34w==
X-Gm-Message-State: ANoB5pmAiDBp7Zzoo+vN1SltzkihSLByxwJGo/bh3a86ymh4ZuNTLjWK
        B+LfEuTNNXP0p7K7N9A2+vOU56vkaYYXNkFr3/DUg9oVQQbyq2KKkJQi4HfjVwmGJpPOP8RU6Tq
        /aZEkjMLaxdQU5Jsmzmgp
X-Received: by 2002:a5e:8b43:0:b0:682:1142:a6a4 with SMTP id z3-20020a5e8b43000000b006821142a6a4mr17234848iom.52.1669738371866;
        Tue, 29 Nov 2022 08:12:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5IYthLs/LJAQqMju+0j/g+gU9kHqjsvbw3RLa5TsGQoctfB3J5ZSIuLFs1VdrPpx+qNH+rlQ==
X-Received: by 2002:a5e:8b43:0:b0:682:1142:a6a4 with SMTP id z3-20020a5e8b43000000b006821142a6a4mr17234837iom.52.1669738371679;
        Tue, 29 Nov 2022 08:12:51 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y14-20020a92d20e000000b002fc61ac516csm4876779ily.87.2022.11.29.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:12:51 -0800 (PST)
Date:   Tue, 29 Nov 2022 09:12:49 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221129091249.3b60dd58.alex.williamson@redhat.com>
In-Reply-To: <20221129160626.GA19822@wunner.de>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
        <20221128203932.GA644781@bhelgaas>
        <20221128150617.14c98c2e.alex.williamson@redhat.com>
        <20221129064812.GA1555@wunner.de>
        <20221129065242.07b5bcbf.alex.williamson@redhat.com>
        <Y4YgKaml6nh5cB9r@black.fi.intel.com>
        <20221129084646.0b22c80b.alex.williamson@redhat.com>
        <20221129160626.GA19822@wunner.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 29 Nov 2022 17:06:26 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Nov 29, 2022 at 08:46:46AM -0700, Alex Williamson wrote:
> > Maybe the elephant in the room is why it's apparently such common
> > practice to need to perform a hard reset these devices outside of
> > virtualization scenarios...  
> 
> These GPUs are used as accelerators in cloud environments.
> 
> They're reset to a pristine state when handed out to another tenant
> to avoid info leaks from the previous tenant.
> 
> That should be a legitimate usage of PCIe reset, no?

Absolutely, but why the whole switch?  Thanks,

Alex

