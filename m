Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D58BD6068
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfJNKk2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 06:40:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43515 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfJNKk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 06:40:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so13325538oih.10;
        Mon, 14 Oct 2019 03:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yR/mNj1Zwd+yFbtuo6NH79a/l5OlQBK6Cgb3kmXbCs=;
        b=Zk2t1BeAy4engQyx9iBaRD/aiEVkcFMRr6wT7wS4aaOrv+GP8SmbuHaqjBen674g/C
         DII3cMfo8IkDRwvNqMYLMnw1/eEHh8S73Fzn5Hnm0ijZMWgDXmBSSV1ziRdvAn6aDprN
         Q+M8bwGb/RU3WA6KKI/Crze3z7MH51naiRY8F70VNCnFuAk88+5QMIqsfPM9Rp0JZm30
         j/W5fsf2of8VPwuZ9Pn1S2OyD4JA/P8IQktUARYeN9sGxc7QAsWser/gVJi2h3W3o4C5
         w6pu4H1KDMzWAjJajq7Qc5jojiHs2ERcYBcO2enM1//zr5GZCCmUY9+wkMnFIzEhWAme
         7WKg==
X-Gm-Message-State: APjAAAVQLeYho16tKj5BbT/gNUClGHWIOK6Yfk/CPpuTx7vd7yzIVFIE
        GsEHAWki/XAQdai9ZzHogkqEG18hGy/VllXUqljRgQ==
X-Google-Smtp-Source: APXvYqzuhT8zAfliT03UCCUeVQ9wvw2YiBnPA2ndB71qcTtsV9ah1EZXLXBOBu3dA+ibOnzXqh8gTptJjIdIRXL94MY=
X-Received: by 2002:aca:d405:: with SMTP id l5mr22892023oig.115.1571049627236;
 Mon, 14 Oct 2019 03:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <261805141.5tZyQaKU0z@kreacher>
 <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com>
 <4883845.KNzyzeMIEj@kreacher> <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
In-Reply-To: <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Oct 2019 12:40:15 +0200
Message-ID: <CAJZ5v0jD_-phNM6NEonc6Z0ONkEdELT+6q_P1hnopM_iNVT2dw@mail.gmail.com>
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 11:46 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Oct 14, 2019 at 5:22 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > While I still think that both the system resume and runtime resume code paths
> > should be as similar as reasonably possible, the above needs to be taken into
> > account IMO, so it is better to retain pci_pm_default_resume_early(), but make
> > it do a conditional "ACPI power state refresh" and then call
> > pci_restore_standard_config().
> >
> > So something like the patch below (can you please test it too?).
>
> This is also working fine, thanks for your help!

Thanks for the confirmation and let me submit the patch properly.
