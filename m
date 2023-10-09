Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812B37BEB38
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378522AbjJIUGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 16:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJIUGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 16:06:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF3CC
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 13:06:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c1807f3400so60244911fa.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Oct 2023 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696881966; x=1697486766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vntWR/EJpWFamZ/9NMXVbCLlV4xDhJbERcnlqbMN6Xk=;
        b=BFuMz3FMbhLgkIJi/HkkmJ1VkLf2I7vqp4svyIwG2+yDE+U4S96EGEikgUcb8O02Uo
         8j8iLlfo7vmxsfcwVcs/qIKkl99xa5dmEeJRo1cSF6V+ygbEal7iO3+v912NQA+dawBz
         Soy5yco9XA4Rbc4rDCwVGkioAfXZalXRitmVvyF0C2rWZ0Ewe2//XA3FBEsbn52apGZL
         aRFt/c7Wzbg6QpYPQ0dm8EJR8fe2x3S+duZuFSIP/H5VlRW/FVRYn5HxOETlTJKz3xcb
         BMDmJLPjWEXQ8IaDm9bc5q/71Ibv+h4ffhs1BXiaAk1KUwUk/S2rUW6zLyroy1Lm1kJC
         OAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881966; x=1697486766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vntWR/EJpWFamZ/9NMXVbCLlV4xDhJbERcnlqbMN6Xk=;
        b=Z+z0Ns92nZJeYha0riAskZEL1lKpICDLWkxSMaZAx6+zkHiwkSHudNZZNqfJlXwDEu
         ARxkJus4sHTjdSJcthBLnqqH0Xefk9IxCx57e80D8V4I5RgMA7wxWZZAak9Bs2eYcOKa
         dsrskr0+frtO9vIrivKg/kZYM5dPUbFGsFLyZys6KWqeuQzLtvOVymj2uv2eLtOyfZj7
         qwozBdja8lvkZERzWQEnN69SA3w968JNLt2ituy2WaeoqgruzK53Ng28qtQffz5iaQ7N
         cQZi7m9Avu0av7WnrIgSVK0oPrnvtfLCtx2EimxyG1FAGdyVeuBNJORR4pyEu5UKMylj
         SKKA==
X-Gm-Message-State: AOJu0YyKQxDLWBF3KHx090ofByBor8GVWrJFYU4EW0O+Y7Elg6pxrOKY
        Ry6nh2sZwFyNBbGZ9hKxDbjfL/qu41Kj8k+2pdc/cA==
X-Google-Smtp-Source: AGHT+IFghqg7b3VfDVvZ+soPEwEaIfxhrwarlOcz2b03PC3KagC0O9BH1UGRNCP79pJ8yT5JMzxC/VoYSKvtKG/y1ws=
X-Received: by 2002:a2e:870c:0:b0:2b6:cbdb:790c with SMTP id
 m12-20020a2e870c000000b002b6cbdb790cmr11535962lji.1.1696881966432; Mon, 09
 Oct 2023 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-6-max.kellermann@ionos.com> <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
In-Reply-To: <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 9 Oct 2023 22:05:55 +0200
Message-ID: <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 9, 2023 at 7:24=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> Also, I don't know why checkpatch is happy with all the
>
>         const struct attribute_group *const*groups;
>
> instead of
>
>         const struct attribute_group *const *groups;

I found out that checkpatch has no check for this at all; it does
complain about such lines, but only for local variables. But that
warning is actually a bug, because this is a check for unary
operators: it thinks the asterisk is a dereference operator, not a
pointer declaration, and complains that the unary operator must be
preceded by a space. Thus warnings on local variable are only correct
by coincidence, not by design.

Inside structs or parameters (where my coding style violations can be
found), it's a different context and thus checkpatch doesn't apply the
rules for unary operators.
