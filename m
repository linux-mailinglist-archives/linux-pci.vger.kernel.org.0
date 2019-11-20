Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E45103889
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfKTLSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 06:18:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35993 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKTLSa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 06:18:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so20874509oto.3;
        Wed, 20 Nov 2019 03:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/5jsqA3ur7CU2+E1FQpTsae3rv8noHoFgxe9X+JsPc=;
        b=XIFIZiZi9m+WaqUtj+LFi6Lo7eUKba+zCyZCtnPoJsmhJMJTxXxNzh/flIxbRRgu6T
         eMZAAXdki393VCTKdD5t40T1dB3MbXXcHpLYDofp2yRcAXdIf2OWRCMhCbtB/elXaY7n
         7y7JOEiV6golajJG12O0DiOyUSFNCgsgQ2dcOj4xhGE2rilP0DSnbvhuWAU3u3m68hrb
         T01Mywcl7H8OmtWkzK+mq9qJpYqi2EmDd2z+A3+YrgetdinHZM5r1oazPtnp3ABcV9ou
         MMPBuWACQr5wG1s+qkp+tc0myFSOHrg2XUG9nCOPc/Of57shRChDLre+zjg9PNQCetZe
         I6rQ==
X-Gm-Message-State: APjAAAW1Zaj3n3tyfpWuyTyTg+A47OqAGPjtwk1W4/jDBt7xz39W6Oci
        ofMuRsbeaUGfusdTsW+pU1Pfi3iAIS3Or2tKBQk=
X-Google-Smtp-Source: APXvYqz8ylWHSce3arRwebwGh9oG7W/+JI7AFLEp2CzmyLVZSRuHqWtxpy2XPBAEE9kkRAuwtkDRFq08XMaRos5hDdY=
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr1538495otq.189.1574248708342;
 Wed, 20 Nov 2019 03:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20191119140923.175286-1-helgaas@kernel.org>
In-Reply-To: <20191119140923.175286-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 12:18:16 +0100
Message-ID: <CAJZ5v0gzspKm_Zy8JzWC54iPfJKU=2Hx_FzP-vLBS=CreyKgbA@mail.gmail.com>
Subject: Re: [PATCH] PM / QoS: Wrap documentation to fit in 80 columns
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 3:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Wrap to 80 columns.  No textual change except to correct some "it's" that
> should be "its".
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied for 5.5, but I've dropped the "QoS" part from the subject, as
this is not only about QoS.

Thanks!
