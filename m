Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 838DD33A85
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFCV7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 17:59:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44706 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfFCV7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 17:59:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so9032056pgp.11
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2019 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsqt76+/tC7lNIGkBOfSxOR0w7kTsY9VRuEizjLylaM=;
        b=lWohiKBqCPBenj/eJUzVHOJpCdAi91g5TtT2pyrV0FfesO2LcED3e8srNOon8Iibg8
         XtIVB4yvu8opanO7FhZdkXkw4qrcWHepKTZehjxMhdJDV96SRObFjXSOJ7rGU53BIOCP
         amFtVM8IVZTgsTynPUL6wWPlqXYRwRZZzxCbIY9Ee0e3Vl33p4qUyAVxj8FpxZ60liZ+
         tlqBRl6mtiIkFKWFCab1uDZBalnO4+vn2OxS13m7xXU6v0FU5TV28RkCj9ovOInxVDww
         AAHmWcMNk0lFA89DRsCsZY4WJwkQ6CMV6qh3KnKzsG3YvEUYZUc8GLtbMBr5SeewywTj
         cL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsqt76+/tC7lNIGkBOfSxOR0w7kTsY9VRuEizjLylaM=;
        b=MFBbGpRO2SwJ5dXaCUTmNZoe8PiAsjHUj4QsDZ9EdJ3tDUBL8Us7m+BF6pHG5WQ7Gq
         xCsDR8DOJZ0SYHQxxNMlJY/gl3IOMaBtvBsELhfeF8q3nwbFpNnGLEoCoz/HgP/Dme/6
         8TSIEN56wEByQKeWz8qdzPRiE0zP7f3QitKkE2oaFFUTF/D50qN16J8dCVySkb6iluI8
         NVzSeMcw2Rm+i8NhEtCdoRcVzOtJI6mwQzeB9tlm8TBunFtuy4yBAArG7hJ853r/7ZhO
         uQ0YIaZVJzfqPnhFslBVnCa2oKub+bja7n1zbpg9iarvUXG7Fx7Z2OzMB2oINcv9bn48
         r12g==
X-Gm-Message-State: APjAAAURt0R9LYqoiq4SzdtHvPt+nzAb/qkrmvV/xpjXaMCKMDsLlMrt
        woyv4B+1DHhV7QJ8T0LAHPHK/IO4XWydTOlhUCSWLRepdh4=
X-Google-Smtp-Source: APXvYqwtRDahz95jt5ckTsuH+i7KTn9MRTd6CF+6hpsuPoa7lkdPVCsC5gUhiu+y1T7oPa6/2fCZnPaB/OkOvv8EDa4=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr5763850pjs.73.1559596083400;
 Mon, 03 Jun 2019 14:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174323.48251-1-natechancellor@gmail.com>
In-Reply-To: <20190603174323.48251-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Jun 2019 14:07:50 -0700
Message-ID: <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 3, 2019 at 10:44 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Looking at the loop in a vacuum as clang would, fndit could be
> uninitialized if entries was ever zero or the if statement was
> always true within the loop. Regardless of whether or not this
> warning is a problem in practice, "found" variables should always
> be initialized to false so that there is no possibility of
> undefined behavior.

Thanks for the patch Nathan.  fndit isn't really being used for
anything other than a print statement outside of the loop.  How about:

```
diff --git a/drivers/pci/hotplug/rpaphp_core.c
b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..c3899ee1db99 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct
device_node *dn, char *drc_name,
  struct of_drc_info drc;
  const __be32 *value;
  char cell_drc_name[MAX_DRC_NAME_LEN];
- int j, fndit;
+ int j;

  info = of_find_property(dn->parent, "ibm,drc-info", NULL);
  if (info == NULL)
@@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct
device_node *dn, char *drc_name,

  /* Should now know end of current entry */

- if (my_index > drc.last_drc_index)
- continue;
-
- fndit = 1;
- break;
+ /* Found it */
+ if (my_index <= drc.last_drc_index) {
+ sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
+ my_index);
+ break;
+ }
  }
- /* Found it */
-
- if (fndit)
- sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
- my_index);

  if (((drc_name == NULL) ||
       (drc_name && !strcmp(drc_name, cell_drc_name))) &&
```
(not sure my tabs were pasted properly in the above...)

-- 
Thanks,
~Nick Desaulniers
