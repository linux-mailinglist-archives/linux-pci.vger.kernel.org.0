Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000071B48E6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDVPjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 11:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgDVPjH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 11:39:07 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5392082E
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2020 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587569947;
        bh=3GC7V64HWd35zrN5I+hb82L1DOfOt7nzVf5YgoW+ZJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ODqD1gMHaY4IC+fT1vSrxC+/PtnVN7BtUtt7ul/ErmZTElX64/BzxB+zg1xRxPoeX
         Brsq06UtcIR3GRxfgCD5vzJjPudfX2BWIpgWsrduQnw+u11TIwOsEdFFAf9deKJRWr
         ZIH3odpz4b+AN/PZqRPnYJlOAY32f0SSO6L1J9ok=
Received: by mail-qt1-f169.google.com with SMTP id c23so1451496qtp.11
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2020 08:39:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuY0q1byWsVLfG1Atrla4e2VeziTVCWSRRe67qvIw1wMCoFNysyO
        6/jrU7Jmrzb8FW0IwIac+wWirl0xmc43OvNQxQ==
X-Google-Smtp-Source: APiQypKqvPl47gP96oQs/vhcARvjaTT97BhkwH+KfLYGBBpwDlQDr6dNn+yIfX9w1NV0ZtihjOslKaUvWRMzDL92NJ4=
X-Received: by 2002:ac8:7cba:: with SMTP id z26mr27280829qtv.143.1587569946382;
 Wed, 22 Apr 2020 08:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200422150336.10528-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200422150336.10528-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Apr 2020 10:38:54 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dPVad=0kB3u0an2znbXr1RdjhkSLG3miOA55Y+XK+-w@mail.gmail.com>
Message-ID: <CAL_Jsq+dPVad=0kB3u0an2znbXr1RdjhkSLG3miOA55Y+XK+-w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Rob Herring and remove Andy Murray as
 PCI reviewers
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 10:03 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Andy Murray decided to step down as PCI controller reviewer and
> Rob Herring is willing to help review PCI controller patches.
>
> Update the respective MAINTAINERS entries to reflect this change.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>

Acked-by: Rob Herring <robh@kernel.org>
