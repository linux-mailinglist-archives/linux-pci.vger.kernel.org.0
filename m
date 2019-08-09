Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A070D873BF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405674AbfHIIFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 04:05:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36940 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405395AbfHIIFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 04:05:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so63905153otp.4;
        Fri, 09 Aug 2019 01:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr58cY4zdsgPpx95oJLIxoU1rGwghcNfH7JlzOMAsu4=;
        b=e0sK0VsHZup9KFeSpSh9/OOOONx1mjeEvSqwXL+8iaPbMj56HchDBd4czh/+VaeVxX
         jVsjzSCjzeN0ShkPBbR6q41Zz0rEp/gNzO0IilX66F0iGbsSvnEDF5HOKdGgPFdgfHzk
         oFP7/b/5GGfQCmueMpYMkb4bIxEXg4sOdCD6x+c07DBRyvhVaNTSYs8qs6Djw0UhdM9T
         LqNka2bfHWOrWwZen6OWOZsfapElfUshrMP+HitoVzm6Oxtuw6tMo4LfrWei0h8ByCjY
         SIthfo9LJiitmDn+GyeRqSdvXvNzATTnc0I3j1/Qa/paWuEVWsiB2ui8icUE5J4e3svi
         dXiA==
X-Gm-Message-State: APjAAAXmSq1UNOatfNtmaDCtZg/qxa/eRw1yidBhSAe6yxdqdbX4TwCc
        Oo7RIPpvWENW0JPOBi2RAA2QaoVVG2Kp1cqiWmM=
X-Google-Smtp-Source: APXvYqwpMqzGpisGEHKCizBrN6MIEGBsCEvXSslf8jFdbZ46Bddh5AKgBJk/fXIOFBpukkxQI73f9PvbdNeJ9XIB+90=
X-Received: by 2002:aca:d907:: with SMTP id q7mr5177724oig.68.1565337953260;
 Fri, 09 Aug 2019 01:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com> <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain> <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <2184247.yL3mcj2FRQ@kreacher> <20190808221353.GA27570@localhost.localdomain>
In-Reply-To: <20190808221353.GA27570@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Aug 2019 10:05:42 +0200
Message-ID: <CAJZ5v0hh3Yfx0Kbt11NEXV9q5RtApuvvg5JZ2O_rZLvixOWSOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 9, 2019 at 12:16 AM Keith Busch <kbusch@kernel.org> wrote:
>
> The v3 series looks good to me.
>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
>
> Bjorn,
>
> If you're okay with the series, we can either take it through nvme,
> or you can feel free to apply through pci, whichever you prefer.

Actually, I can apply it too with your R-by along with the PCIe patch
ACKed by Bjorn.  Please let me know if that works for you.
