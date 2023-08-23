Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2EA7859F7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjHWODd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHWODd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 10:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E212CD0
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692799367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERUI+NK+jUnEExmqCqtfIrVKBUpED9COp25lOAtb1+k=;
        b=T++nq0FWg3piBDc2z/tAGGAHPmh9ksHC4Dupj1PCrp7pYFlnFozKEcuF93TBKgdu6ZYgXs
        vUvpgq2EpVRHWMI19MKlY0fC25QeYqcAmaQrWAPdw3sy7BJPdBEh7njAfPSKyn7oHH6vC/
        0kaPpwRUnd6nxzeeS/4Po12mcn1hkXE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-MTpPGWwdNN-P7LedSTUn1g-1; Wed, 23 Aug 2023 10:02:46 -0400
X-MC-Unique: MTpPGWwdNN-P7LedSTUn1g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26f591c1a2cso3759122a91.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 07:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692799354; x=1693404154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERUI+NK+jUnEExmqCqtfIrVKBUpED9COp25lOAtb1+k=;
        b=jJQklE1AQB13756C8tBcrKZ9Ta0IXkUfNRQ9vqLDYV4YvxRWzRACYbxSQrjI2w+mfS
         ojXCd34iK3DmNlJLqO1xJgAQByd/UuVw0hNpRuBp6pQW/Em2I06pqtI24uHaM8HatmdJ
         fO+BJPVIJb7iUHc666rUkOtqloJEMmAsuYmJO0h9jv0DXoWHrc+n/2PpY6Z9omzwIs1n
         gBpW/EMUkdkJelPRDY2zWSUfDRCRytYE+Yv20djfkPf5xnuF9f9gZBqLd8WekwpjIYrc
         /o8sgMul4MIF6XySayK+gvICiY6XEykCNo4ObmdlrHnu1YhoCc4N1naWEGcDXOBsvgXq
         74eA==
X-Gm-Message-State: AOJu0YygwG+lmY6EbB9LtuemHW1FmthdvWVY8e3b37iTLm0owfIDJLgm
        yBI0m1wNyIdXLKEw43xcCd65/zy3Pgm0c5NsNUfuoxQ6IPeIpjpFw8R217H1eGCEbzH1btrIaBr
        hlqEOuzqMxmBgehieI8u/ETFciJDESHas9P4=
X-Received: by 2002:a17:90a:7348:b0:269:25a8:66c with SMTP id j8-20020a17090a734800b0026925a8066cmr9103882pjs.45.1692799354047;
        Wed, 23 Aug 2023 07:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW15JE4LCJ/KkWX1lMJBTT7PNOrDO2QO/djYtszrlFSukD3QntsPQ15tf/oS3atq2ke0SzXuOjqxDb14QYQdk=
X-Received: by 2002:a17:90a:7348:b0:269:25a8:66c with SMTP id
 j8-20020a17090a734800b0026925a8066cmr9103833pjs.45.1692799353440; Wed, 23 Aug
 2023 07:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+cBOTeWrsTyANjLZQ=bGoBQ_yOkkV1juyRvJq-C8GOrbW6t9Q@mail.gmail.com>
 <20230821131223.GJ3465@black.fi.intel.com> <CA+cBOTc-7U_sumg6g-uBs9w3m8xipuOV1VY=4nmBcyuppgi8_g@mail.gmail.com>
 <20230823050714.GP3465@black.fi.intel.com> <CA+cBOTdS5djXL=93VThP9K67pjYKHtjceqSczKf8NQonhpgo5Q@mail.gmail.com>
 <20230823074447.GR3465@black.fi.intel.com> <20230823075649.GS3465@black.fi.intel.com>
 <CA+cBOTco17b_8ZMhU8gXy8z2mtZXvVxrEUdKaAuZMhyFYC3yeQ@mail.gmail.com> <20230823090525.GT3465@black.fi.intel.com>
In-Reply-To: <20230823090525.GT3465@black.fi.intel.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Wed, 23 Aug 2023 16:02:06 +0200
Message-ID: <CA+cBOTeOSBkw_-AM6desmdVQjTXUZbKppK_PDiOM3sXQW5QKiA@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 11:05=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> OK. Did you change any BIOS settings from the defaults that might have
> affect on this? Sometimes these are exposed to through the BIOS menu and
> the user can change those (Lenovo typically does not, expose them
> though).

These BIOS pages seem they could be relevant:
https://imgur.com/a/vEltxpj

And heureka, "Thunderbolt BIOS Assist Mode" affects this! It was
disabled (not sure if that's the default or I changed it before).
After I enable it, the resume 60+ second delay is gone, it resumes in
standard ~5 seconds. The dock devices (mouse, LAN) still take a few
extra seconds to activate. The dmesg for a resume with TB assist mode
is here:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984785

Unfortunately, it seems to have its own quirks. There seems to be
something like ~20% chance that the dock devices are no longer
available after resume. I see the dock as connected in boltctl, but I
no longer see the devices in lsusb. Reconnecting the dock doesn't
help, more suspend&resume cycles don't help, only system reboot helps.
I captured this situation in this dmesg (there are multiple resume
events, the devices disappear after the last one):
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984786

This might be the same problem that I described regarding
pcie_aspm=3Doff to Bjorn, but I'd need to check. Either way, this wasn't
happening when the TB assist mode was disabled.

> Can you also attach output of acpidump to and dmesg with
> "thunderbolt.dyndbg=3D+p" in the command line?

acpidump:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984802

dmesg with "thunderbolt.dyndbg=3D+p" and one suspend&resume cycle:
https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1984803

I'm currently running kernel 6.4.8 packaged in Fedora 38 for these
experiments, I hope that's OK. If needed, I can switch to the latest
kernel.

