Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9499610907E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfKYOzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 09:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfKYOzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Nov 2019 09:55:52 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDEBF2084D
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574693751;
        bh=Rxky72PqstIbIlKI/tQIOcS9CSX6zD0sQOuqRSkAbfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jkdf/7MjXmux3932g1T35YDJErfO4O/Hd6dOGdf0AW6G2GwaQZErpt7JiTohVjca9
         iXmejzu+/wYpKw+xwMrql6BcWA0vzVnN9yyEV22UOfJUxIMJc9HmPIQm7CUbBFnvHA
         p8DAQp1geBRyaNtwL/83HTRKzznZ7owuQoFSV1Fs=
Received: by mail-qk1-f180.google.com with SMTP id m16so12905490qki.11
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 06:55:51 -0800 (PST)
X-Gm-Message-State: APjAAAWlHsO4TqfKwPf5q2bTnxVD6fczHFtZL5lhTFczk4XWWwbaEFUx
        Q7eZnpRuU/oWh+1GIuyEm1SWAyiXyLikJvDcuV4=
X-Google-Smtp-Source: APXvYqyqpZ/vCxtErRlNJFtu7hfc+t7+vo0/X9gR4FrRc0kI9p7P6lPw70p3sR7aJWPnFo2VSF7IHPauCrzFbIc+0EM=
X-Received: by 2002:a05:620a:120e:: with SMTP id u14mr1392078qkj.325.1574693750891;
 Mon, 25 Nov 2019 06:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20191115135842.119621-1-wei.liu@kernel.org>
In-Reply-To: <20191115135842.119621-1-wei.liu@kernel.org>
From:   Wei Liu <wei.liu@kernel.org>
Date:   Mon, 25 Nov 2019 14:55:39 +0000
X-Gmail-Original-Message-ID: <CAHd7WqxfQg4FXTBqmtMraL4Dqy6zk5uFP4wuxjsY2ns6j=cP9A@mail.gmail.com>
Message-ID: <CAHd7WqxfQg4FXTBqmtMraL4Dqy6zk5uFP4wuxjsY2ns6j=cP9A@mail.gmail.com>
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        rjui@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Nov 2019 at 13:58, Wei Liu <wei.liu@kernel.org> wrote:
>
> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
> in.  Removing the ifdef will allow us to build the driver as a module.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Alternatively, we can change the condition to:
>
>   #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
> .
>
> I chose to remove the ifdef because that's what other quirks looked like
> in this file.

Bjorn and Ray, any comment on this trivial patch?

Wei.
