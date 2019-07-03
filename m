Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7265EAD5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGCRu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 13:50:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33932 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCRu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 13:50:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so3455633wmd.1;
        Wed, 03 Jul 2019 10:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hndznlvzR7hCc155DH4EmepiersU9zF+O4Q02wI0fg0=;
        b=n1GnBdtPl8nGS9zzV/3N9Hrc+GpPT5sSGK2nG3w3aRr4TrjusI/AggLMIBZD2hbZOZ
         q5CMb6XqCdrJjzMmrtbxANIih+wRn/hbDEoYCjQ2veMG8jndUpXtOFlYs0m8XPUlZwlp
         /IfmVs0DeDoMXQDA0WjV25Z5OexTafr5lpV9BpBGQw9Udf5NEpG7e3zEho2u/F3MyLSd
         HWq5gOD0jsUrX3HhbIu7wrDhyYV3uKjfhy8gSoe+HkrOPg/OkbU7kQGhoZjkAD/lAARK
         uYeYaadoPRlwrIxOELmFroz8KzWCm3Msu6ytF0yKZFHkFtTKvR9/8qIR0w0UWWLrNGUg
         Jngg==
X-Gm-Message-State: APjAAAUpRW0in7OZJ4A5CUbUWjIANe2gHd51okIwxdSoo7c85KQj8I56
        DQfqes96nB3rgelbqLC7fImukSZ6Mhxjyz7buKvhxQ==
X-Google-Smtp-Source: APXvYqwbLyqNJUgVnFhv0lbJ8SC5c/0yPQg1tb9jN6EfSosXHl80EFPU2XUiDskY7sdqSQfVQLihXsM+BDW3vYzudVA=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr8920034wmc.169.1562176256213;
 Wed, 03 Jul 2019 10:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190701062020.19239-1-hch@lst.de> <20190701062020.19239-21-hch@lst.de>
 <a3108540-e431-2513-650e-3bb143f7f161@nvidia.com>
In-Reply-To: <a3108540-e431-2513-650e-3bb143f7f161@nvidia.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 3 Jul 2019 13:50:45 -0400
Message-ID: <CAKb7Uvid7xfWNRxee4YoDSKu5-eizo-0Bqb3amFczEDXmSKLMA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 20/22] mm: move hmm_vma_fault to nouveau
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, linux-mm@kvack.org,
        nouveau <nouveau@lists.freedesktop.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 3, 2019 at 1:49 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
> On 6/30/19 11:20 PM, Christoph Hellwig wrote:
> > hmm_vma_fault is marked as a legacy API to get rid of, but quite suites
> > the current nouvea flow.  Move it to the only user in preparation for
>
> I didn't quite parse the phrase "quite suites the current nouvea flow."
> s/nouvea/nouveau/

As long as you're fixing typos, suites -> suits.
