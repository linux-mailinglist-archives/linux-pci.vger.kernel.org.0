Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A20E80B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfD2Qpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 12:45:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41713 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfD2Qpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Apr 2019 12:45:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so5584863pfd.8;
        Mon, 29 Apr 2019 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JT+ML2dX2Vx8dyF6/A3Qn82bt73Gd/sl6N1Ui3j3HLI=;
        b=hXodwy1aIvm5ESAQj/9CsoafzYXwu6ZkSxMhNTBCZG9FeRCS+T9lrCIWUNGxUhuIeX
         QuxxMVX8gfHvWi8NN1m05PQonHBaQqUfw9aNdUyA+MmHJfwtXZ4dKFKHyj+HbR+7LivD
         nP+l9JmJAY4Bb2vi4mSrCd9VXgChu7T3zGU5+3hL45gcOUwT1BEZYfqxjpSkTgF2QYi3
         J1hqh6SxEmmXyYBiBUu20T/SogI7Grp+HvSyO61UrWhbhMQtPwQ3xhMgnMLWUocmYSp2
         J8DM9cxKFXstk9JvzjrS2ODfMksQPgWCmIn9QvNQeiqU0wpsSILxYUOiMoMcKh8fc4Tj
         Nz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JT+ML2dX2Vx8dyF6/A3Qn82bt73Gd/sl6N1Ui3j3HLI=;
        b=Vth1QiUAhA1mt7UrOspyMB/d5K9RuGsUzLVR855+h06pc9eLG8zt7kH62ktBRqaKFH
         VzyenO+1I8J5mWqHOcL3SFYe8pZSdFyC+HNBuxBBcH3ya+itDMLg4uN1IW+G13Y13BQQ
         C+pWDcpLhDZeaNgOlp3bqn/nztP3NQMEB3Kc1mUZVBems825zmrNgQo28cwL/9Jp4yo8
         yVnJvRfjMVqiHpryp6KjN1uX6DyvPjIiLGbIT87cmAXFEpQpOxHCm4379ey+A2KZgQOp
         QeP92IMUHLuVKbtPLXERY66C88+Ov/16q5XSXlWP0ZRZL+TnATLqSHqjqksHXQLYRWeF
         gS/A==
X-Gm-Message-State: APjAAAVEF3EFKy3XwzrTzCpM0+sRHHmQFD5yDueqWZrMaYoM3kVIMvS0
        2C1OqBBcQJ70YOQnwTMQ1Io24F3d
X-Google-Smtp-Source: APXvYqyQY7jrGrCLUpImEXnQs8adfZe3HvjIMZqonhLcCcNeNgvucZsNvfkxbFYxkbE6/fSIqGZcaQ==
X-Received: by 2002:a63:564f:: with SMTP id g15mr6328290pgm.258.1556556331159;
        Mon, 29 Apr 2019 09:45:31 -0700 (PDT)
Received: from [10.70.64.58] ([131.107.174.58])
        by smtp.gmail.com with ESMTPSA id e16sm21129942pgv.89.2019.04.29.09.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:45:30 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
To:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
 <20190424175758.GC244134@google.com> <20190429085104.728aee75@x1.home>
Message-ID: <76169da9-36cd-6754-41e7-47c8ef668648@kernel.org>
Date:   Mon, 29 Apr 2019 09:45:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429085104.728aee75@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/29/2019 10:51 AM, Alex Williamson wrote:
> So where do we go from here?  I agree that dmesg is not necessarily a
> great choice for these sorts of events and if they went somewhere else,
> maybe I wouldn't have the same concerns about them generating user
> confusion or contributing to DoS vectors from userspace drivers.  As it
> is though, we have known cases where benign events generate confusing
> logging messages, which seems like a regression.  Drivers didn't ask
> for a link_change handler, but nor did they ask that the link state to
> their device be monitored so closely.  Maybe this not only needs some
> sort of change to the logging mechanism, but also an opt-in by the
> driver if they don't expect runtime link changes.  Thanks,

Is there anyway to detect autonomous hardware management support and
not report link state changes in that situation?

I thought there were some capability bits for these.
