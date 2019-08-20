Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C796AF0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHTUzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 16:55:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42781 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfHTUzt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 16:55:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so59734ljj.9
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2019 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDtE7b4NYnNYIMbB1I2q4i0yK3tBX6HR4LJT1fdv2eE=;
        b=gJPld9l2ErA0n690vu3wDj4eKvYBYriBt5CI8ZRAWFgoW7C5PpaKNpcDEijKtCCNv6
         Rg6Fjug/oIfylvhgpGEtfDZJ2x3JLVgwDm7Em8NxI1jx4DN6yTdQ74Ys1W92mgaeP6BI
         m6SjayfpFCO7fizz9Q3rYZb9lOEMYptlWISmXCzx3LHJ58avkvMGq4wPc5rPD78aeUWP
         j52dxTBdx0uJfLvf/BzVGxmOvKDG58nwoFW1jcBoh79C4aoiQJgXmos5Qzsu8vno0t2A
         AL3pUqgo7InHtFkWIH+Ye9qtpol+5KDu85zQdS1g9HPvJTphQpU6+fAw1xCfYFommfMM
         20nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDtE7b4NYnNYIMbB1I2q4i0yK3tBX6HR4LJT1fdv2eE=;
        b=EojZsIMpeqJCI/SkeWIukmiTtf4yo3yis6B4S5vNAbPVLD1FaDL4pDv2urrEDYcCTP
         mATnSQLuOytYRvfW28xf+hFAFKiqifZ6rQcjT0M9V5F95N4F9nmNXs88J1x80gybpj/U
         JmnEYiba2FSA1LQsPCghHtWbEOC5DBpAi70ZVN1boyzpk3F7pPJbsAN46L90bYH/RERH
         /MRIJM9MuBhLVnsvQVGHyyHVXwHdjUL2IuLdMN4b3RENby3KzR0uWNlFuwXFxH9LY78d
         VrmKRgUDib4kPb3O1/+n7aHZDKOYn6pu7+pKSGkNE0LfRmKQFhkM8xCm/sSYvPr+a9rR
         /A9w==
X-Gm-Message-State: APjAAAWIJxwmprQDgnwxtW7JNIKzZEC9IC/WetbjyeooDh0xFfRe/D1x
        goPpopMI6mVAcNw0TRPcg5CO2GMrsUJniUtcH3ZcYw==
X-Google-Smtp-Source: APXvYqzlvuVgHRZqAqRB/YyEqX59UM0QWHbNxhFKBnJ5OTXY0+mLAI8sKkdv7vDw8lrPe+PLNRvhW+YB6gaZ9ewyxFA=
X-Received: by 2002:a2e:98c9:: with SMTP id s9mr1859768ljj.176.1566334547423;
 Tue, 20 Aug 2019 13:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com> <20190820103400.GY253360@google.com>
 <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com>
 <20190820193252.GB14450@google.com> <CACK8Z6GuzQAoSnDD9chC9yXrPrc3FTtzkiDXMTXdY4MnePgj8g@mail.gmail.com>
 <20190820204845.GD14450@google.com>
In-Reply-To: <20190820204845.GD14450@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 20 Aug 2019 13:55:10 -0700
Message-ID: <CACK8Z6ECUwnupMZtY3fyM46za-7WZyJNQYYEFchUWLDsgOMbvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 1:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 20, 2019 at 12:51:09PM -0700, Rajat Jain wrote:
> >
> > May be we're digressing now, but I'd like to point out that there is
> > atleast one more file in ASPM that potentially violates the "1 value
> > per file" rule:
> >
> > rajatja@rajat2:/sys/module/pcie_aspm/parameters$ cat policy
> > [default] performance powersave powersupersave
> > rajatja@rajat2:/sys/module/pcie_aspm/parameters$
> >
> > ... although I would argue in this case that it makes it much clear
> > what are the allowable values to write, and which is the current
> > selected one.
>
> Huh, that's a good point.  That "policy" file is a little problematic
> for several reasons, one being the config options
> (CONFIG_PCIEASPM_PERFORMANCE, CONFIG_PCIEASPM_POWERSAVE, etc) that
> lock a distro into some default choice.
>
> Maybe there's something we can do there, although there's legacy use
> to consider (there are a zillion web pages that document
> pcie_aspm/parameters/policy as a way to fix things), and it's
> certainly beyond the scope of *this* series.

Agreed!

>
> Bjorn
