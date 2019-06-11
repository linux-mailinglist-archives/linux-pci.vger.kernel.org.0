Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6683C4F9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfFKHWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 03:22:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43985 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404144AbfFKHWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 03:22:39 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so9012736ios.10;
        Tue, 11 Jun 2019 00:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LMBDzxcOPQJzAsIqFsXcJ+hJWgYhu0NeCp1MT5yfXg=;
        b=FHq0FbaARk7qd+xa7TQ0aEfM+BpccCfD4yzfcIxgecTOyCOCM8E4xrn+bfhOx7gmi/
         O5gbNoXklVKR1UAkV8vY7rQ+EYg++DA91RQrjhC5GNMw1f4/cmJ6ClecNmdnFyGTQDgC
         OxyRVqp+BNCPdgBS7+GibQKvCImmI7RfQE3sybJKSAkBwJBFnrRaq2L9Q021hUIk+vRx
         uQ9zFbYl/ACQ8GFmFCFXMKiJE0onOwifaByUTsVOdq81hsBLSUmyTTdW1/spfzW2ftgF
         zuyybmJODSXCKUhWbPjMHdntNdPczqoH75c8kZSbs5P7hYyYxqKtrP1Xp/UGbGJIV7UT
         0OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LMBDzxcOPQJzAsIqFsXcJ+hJWgYhu0NeCp1MT5yfXg=;
        b=ilWz5ph3x749GABc9Gipjpt4iUbG7icl2rbmuraUjfA4q3LFHQm0O8tnJK55ajWLRn
         zqqTyoxcECPOIQoXmbA6eFVGmi3yZJu1DLXexiRVEjmE7ETEKFQ5OBJ8nxOt2QUkuQkz
         rsVo/x5ZkZ5IkRyYR6F/VAnb8rxqRUNHS5vklG1bF9ehNXkR0MFcKc8PPOOd7XOK9UxL
         qPAp+o1Z8P/Yibrc4gW1hDyTpwFYK5d88PQ4Q1AXZ8vnKscsV+yPhZnEaR3EyRje/8PX
         F73I8GgmsIL04+PlTjWc+BmidGutkv6kpU0uT6BVdtkcyiRQuSXCYJeh3dI5JJ939sNm
         sarQ==
X-Gm-Message-State: APjAAAW3gbyAVCp6hcpZqyMjIuc5QPW317pM7YnMbjagLZg4NgMn53Oi
        Baq6ciBD8QgYB3lsQtsnIsOmw4MlsZnEc2CFtWE=
X-Google-Smtp-Source: APXvYqwSEatUAUHnwa2eQgB+oZehs+SchgSvgHOoFxomWdWFtNczH8rCF6rPDkyqDUA4rknvSQYdQEmjavh4bBJtZvc=
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr28485970iod.145.1560237758377;
 Tue, 11 Jun 2019 00:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com> <20190604131848.GA40122@google.com>
In-Reply-To: <20190604131848.GA40122@google.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 11 Jun 2019 15:22:27 +0800
Message-ID: <CAFiDJ5_e_iuLPUFnwPo+Sq0C9N_OgFmafJ7dCKZE-7hUC=q1YA@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: Allow building as module
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 4, 2019 at 9:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 24, 2019 at 12:57:14PM +0800, Ley Foon Tan wrote:
> > Altera PCIe Rootport IP is a soft IP and is only available after
> > FPGA image is programmed.
> >
> > Make driver modulable to support use case FPGA image is programmed
> > after kernel is booted. User proram FPGA image in kernel then only load
> > PCIe driver module.
>
> I'm not objecting to these patches, but help me understand how this
> works.  The "usual" scenario is that if a driver is loaded before a
> matching device is available, i.e., either the driver is built
> statically or it is loaded before a device is hot-added, the event of
> the device being available causes the driver's probe method to be
> called.
>
> This seems to be a more manual process of programming the FPGA which
> results in a new "altera-pcie" platform device.  And then apparently
> you need to load the appropriate module by hand?  Is there no
> "hot-add" type of event for this platform device that automatically
> looks for the driver?
Yes, we need load module manually now.

Regards
Ley Foon
