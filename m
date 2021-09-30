Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF041D88E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350386AbhI3LVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350387AbhI3LVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 07:21:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6CC06176C;
        Thu, 30 Sep 2021 04:20:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s75so5867202pgs.5;
        Thu, 30 Sep 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CgQJ7TRp+plPGkNDrMGOcj0htBXUR9OYy7BWH9GhPM=;
        b=gjG9GFoMwgCB/asQWkGLcPiv7I7dd8FvYTIqmZZE6cyIPkk5afFfHRenu7G20tflHN
         j4rJiMqHpXWudCF9n8xc9MrvMN+yoju9bNOHA02HLySurdI0tHwGeFJIV1EKeuI7jPHm
         ROimCE1tT4CBilKK5G6/L/XJV7KEyT5CaGj6Br9dykSiI9WlUXDvxNQPFNqH8kcL2QpA
         5SbfMWJjVZKr0PMX6SFsJl7EWqCgvIhm6VPNAZREAwC+LLXvzSIcZb198EAHwGklYHHv
         H8bRbdSZjrG8MwfGQ+f3LV7wHT6psG1FKJwPgZJCF6LfC5NWdjgz44qR93mCdzms0BQO
         f7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CgQJ7TRp+plPGkNDrMGOcj0htBXUR9OYy7BWH9GhPM=;
        b=TMpwwh28EWxELw2bx0usMFa937hHRzLJ6k2MZH7/FkrPXgGo6G+DpqPdAlEcDwWLH3
         /kqZq+hBEwA5XHjcODy1Ub6igSf+248g7o7YGlDwgxeLAPire0LzLZa+ZXvran9Xrp9I
         RQ9wu1h1EYsvLMtE0YNfdtvfa8zdoELTXGSplsn7prXn8G1LYGERAW+0Dlr8EgSlIbbT
         VV2IuHB2j/KLKO/jh8RiCDIh9zfgIIjL3AttITdGuFh1easOYE9VUdmszAc4th/fMKty
         sg8TPCitkpR0GmUzOuFQkpcze3w29EaAzaoJ+Zb8fAZTPUJkU0P6z5f6CgvCB5rnpUPv
         vRIA==
X-Gm-Message-State: AOAM532jzd7rVtWqGxioBQ1DALyFAiVzRssXq8xirF5yINscjkbwQKq5
        kbEJHNQQyibUcYqO8L/gAXqQF+40ztC3POGNIfDyvtwn
X-Google-Smtp-Source: ABdhPJzFEi4IP6RI5YrTNhB/vj9MyeeE4W3MgV7dmTNmrzPxPxolhwys7nBdKNUL3IA6eQsQdLYNcyrOCALuW2HLVT8=
X-Received: by 2002:a63:d351:: with SMTP id u17mr4453357pgi.174.1633000803750;
 Thu, 30 Sep 2021 04:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 30 Sep 2021 14:19:47 +0300
Message-ID: <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 4:05 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> no functional
> changes other than value 2 being not visible to the user.
>

Are we sure we don't break any user-facing tool with it? Tools might use this to
"remember" how the device was authorized this time.
