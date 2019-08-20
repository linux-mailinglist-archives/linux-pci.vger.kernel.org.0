Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37AE96B09
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 23:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHTVEx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 17:04:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34050 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTVEx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 17:04:53 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so288442ioa.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2019 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm9I+GQ2n0FdMH4XuFtRjwWwTD1E/V+vGExol6/H8fs=;
        b=OPK0dobmp+UG+uCm1zUHDMJS/ctyDEWhRWvT2V85npX7tErymXiDmtDjc4c3rNun1a
         HKd+d4hyD6fcNG4KOZ1BmKp0dVbq7jP1ztLcjCfbidOxVRTBPDveEtyTa/e81Cekht6e
         lg1VlT5BuJW9VIYGhdymDuDTppd/HS3Czp4+SfG29UqUtmuzKhfTfloYW75AvwP40WHQ
         FPPEHYEhznSgNu792pi4dKF2BvbGqR9OeXna4Ah1305SJ5n0riESbSAhTAb8/DOIrWw1
         5AQAHL7vBJCTYismH4rRXTfNa1f5R32BWiX5gRhIZ3/e+N/qA/FojiowmsuFLVH0QkUV
         d3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm9I+GQ2n0FdMH4XuFtRjwWwTD1E/V+vGExol6/H8fs=;
        b=EFt6FIvW3BuH16DZUKqMe1aB6yZegk+C6hUa5mE73M/0HS7Dbbj1ip3cQ6+h0EiRr5
         VASGA839HAxHXNRWGywHcbQjKoaXJrFT4oDoh+ekFQl06zRQI9ecRDTpQChezpxgmUgZ
         0up3VwM8dHH7L7boX3EW0JALvZDjyfYoTUBiuwqxFO1yYAz2OxFhV2BcPzZrrNbP/rcU
         1OYM/G6HGcSecOXfxTCZChWw+sVg7SRu1PIEwQ3n+OF9oJfEkA/LYcw0elWmmW+yhcfG
         EzEnFbIo0gJRWDUdBVbjrGKuUPD0eRHAwrRmsWI0/McMXcHXzYEgeVdAerCsqi658Rmx
         Asow==
X-Gm-Message-State: APjAAAURd2kzYqgMfgDGPa5/KG5XtFqM8f2nsfeThl5KVvgCCnK3mLtI
        L1+1TjWxNF9tteHqurQriAWfAlvTuix3V5sAUw7KsQ==
X-Google-Smtp-Source: APXvYqzhxeo9szF/4ykwTQk9wVoapKUSKSJBqxEqQLaMRF1qq9d3WcSi+ZBIGlrHPcm47UTiWE9r3tGCtJ36VVXdm40=
X-Received: by 2002:a05:6638:303:: with SMTP id w3mr5861169jap.103.1566335092334;
 Tue, 20 Aug 2019 14:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-12-matthewgarrett@google.com> <20190820194514.GC14450@google.com>
In-Reply-To: <20190820194514.GC14450@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Aug 2019 14:04:40 -0700
Message-ID: <CACdnJutVe5O2bJZLWQL=e2msudY_i0Mq6vj9B0NautnjRqRVfg@mail.gmail.com>
Subject: Re: [PATCH V40 11/29] PCI: Lock down BAR access when the kernel is
 locked down
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 12:45 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Since I've acked this and it's 11/29, I've been assuming you intend
> to merge the whole series together.  But the fact that it's up to V40
> makes me wonder if you're waiting for me to merge this one.  Just let
> me know either way.

James has merged the series.
