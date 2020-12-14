Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2785C2D9F1B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440880AbgLNSeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 13:34:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33588 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440896AbgLNSdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 13:33:55 -0500
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kosem-0007v8-4H
        for linux-pci@vger.kernel.org; Mon, 14 Dec 2020 18:33:12 +0000
Received: by mail-ed1-f72.google.com with SMTP id ca7so8747894edb.12
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 10:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC5rTts+mOzcrtivhr5wMtWrTwvDKun97Izjg1g5DwM=;
        b=OUCFU9I9AA+0WjW88BiOOTP8RphkQ+r6+Z8fyhWlfTi184clYhIg7OqunaLzDEIVHN
         aziNmUr9IG1OeYZaSgJAt/+RC1C3GDcz6CK1XNwpBE5NMVAFOLGoS076dN8oDzWZEhFE
         z/fVgC/3i0mVR+5NVxQ4kDea1fRbncO6zZ+pMWkyAVAJLduGB7fzIZdKjbwpZvpYG2xw
         rzjhFT1R+rZ/lqY/1u3/oweIMFRkHCVpB2oaI9QLykcJ+TFvnCtrxgmphbs+Oz/knXvi
         DiHuTsw2LVJBb6BVmHXmbh+86+nYHgxV2f5Be+qu/f5+5uvoro3ephG8oyFnggAEWk3D
         k/0g==
X-Gm-Message-State: AOAM532zOWjMiR7bpMezTxYAIH6o/PhWYWNGbh8zWGFmvC9Ke6WVkXI8
        32NsetB7jBVlQCNeXsgU/1PLO0AvhRxOxf+lDZOtCIMyx4Dw4s2stCHpdYw63NjlZRiMyZy5qt6
        HMmk5qcL0kmf4YJFvHsT42K7l5JBblmSuDaZHJtCkJa1CWSQ0Ah9T+Q==
X-Received: by 2002:a50:ed04:: with SMTP id j4mr26821193eds.84.1607970791737;
        Mon, 14 Dec 2020 10:33:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKhS9zZJoH5y+WjTKhFM+13gIWs9+51ExLKCSPqVyqui+xXMHuPFwo81j9PBZsvzg/q2ofOvchb4pAtUadEkg=
X-Received: by 2002:a50:ed04:: with SMTP id j4mr26821177eds.84.1607970791542;
 Mon, 14 Dec 2020 10:33:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
 <20201130202021.GA1106292@bjorn-Precision-5520>
In-Reply-To: <20201130202021.GA1106292@bjorn-Precision-5520>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 14 Dec 2020 15:32:35 -0300
Message-ID: <CAHD1Q_zKmQawrOQrR3DM0nnBF06nO=L_PcMEQMBvZA6xKMxtWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for the clarification Bjorn! I was on vacation..sorry for my delay.

Closing the loop here, I understand we're not getting this patch
merged (due to its restriction to domain 0) and there was a suggestion
in the thread of trying to block MSIs from the IOMMU init code (which
also have the restriction of only working in iommu-enabled systems).
Hope the thread is helpful and if somebody faces this issue, can
comment here and at least find this approach, maybe test the patch.

Thanks to all involved!
