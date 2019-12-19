Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD47127047
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 23:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfLSWEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 17:04:51 -0500
Received: from mx3.wp.pl ([212.77.101.9]:15408 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfLSWEv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Dec 2019 17:04:51 -0500
Received: (wp-smtpd smtp.wp.pl 9783 invoked from network); 19 Dec 2019 22:58:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1576792688; bh=U3hTsTfz2pQGnZHHvq53apeM57BQEFFHhS/MY9yjBl8=;
          h=Subject:To:Cc:From;
          b=fQhthJgk6C8KgObPiwTPoI4nA7FDmICLYBQRCPtCAQxhDcqRoF7yy7MVyjpaXSZZe
           Ci3QvCIiCgWra9qUd4e0qa206RDuIWg8QPDRVpMYcIEp4rsv5qe54ekC9VGXdlXvJk
           fn6x6LD/u8eWyWfsOLPB9jLA7vjYEivDeClErF4w=
Received: from no-mans-land.m247.com (HELO me.smtp.wp.pl) (mszpak@wp.pl@[185.244.214.240])
          (envelope-sender <mszpak@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-pci@vger.kernel.org>; 19 Dec 2019 22:58:08 +0100
Subject: Re: [Nouveau] Tracking down severe regression in 5.3-rc4/5.4 for
 TU116 - assistance needed
To:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <c34a6fe1-80dd-a4db-c605-0a13c69e803f@wp.pl>
 <CAKb7UviSYORoeDm1sbDFEzkGd68+DV=StCpzsiaGbA=1VQX3gw@mail.gmail.com>
 <233aafa2-1474-39bf-8ea0-fe1a3ecef167@wp.pl>
 <CAKb7UvgOVrwC91ys19uTAG2p_MRVqcsV_MAHOSL4-m3f+j=dNg@mail.gmail.com>
 <68def665-d236-f3e0-7033-bcb9b9436d1c@wp.pl>
 <CAKb7Uvion7KuwgNaz0G3UD15nnkfM8hfayQgDtgz4d8W6p98bg@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_Zaj=c4=85czkowski?= <mszpak@wp.pl>
Message-ID: <b0899b99-dcb3-dcf2-5254-bcfd01373cdb@wp.pl>
Date:   Thu, 19 Dec 2019 22:58:08 +0100
User-Agent: Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKb7Uvion7KuwgNaz0G3UD15nnkfM8hfayQgDtgz4d8W6p98bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-WP-MailID: de4e619f7ceafc64b6d80119caa3babe
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [4bGR]                               
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-12-19 21:38, Ilia Mirkin wrote:
> Let's add Mika and Rafael, as they were responsible for that commit.
> Mika/Rafael - any ideas? The commit in question is
> 
> 0617bdede5114a0002298b12cd0ca2b0cfd0395d
> 
> Marcin -- would be nice if you could confirm that taking a recent
> kernel + "git revert 0617bdede5114a0002298b12cd0ca2b0cfd0395d" works
> well for you.

I gave it a try, however, there were subsequent changes in the
neighborhood and I'm not sure how to solve the conflicts (as of master
today). Nevertheless, I should be able to test a provided patch to
verify that some assumptions are right.

Marcin


> 
> On Thu, Dec 19, 2019 at 3:27 PM Marcin Zajączkowski <mszpak@wp.pl> wrote:
>>
>> On 2019-12-16 19:45, Ilia Mirkin wrote:
>>> The obvious candidate based on a quick scan is
>>> 0acf5676dc0ffe0683543a20d5ecbd112af5b8ee -- it merges a fix that
>>> messes with PCI stuff, and there lie dragons. You could try building
>>> that commit, and if things still work, then I have no idea (and you've
>>
>> Nice shot Ilia!
>>
>> I managed to build kernel from suspected bd112af5b8ee and it fails
> 
> Took me a while, but this is the end of the hash. Normally you list
> the start of the hash (and that's what all the git tools accept). In
> this case this is commit

What a bummer, I knew that...

> 
> 0acf5676dc0ffe0683543a20d5ecbd112af5b8ee
> 
>> miserably (as previously described). The build from the previous commit
>> 86a04561920b works fine.
> 
> e577dc152e232c78e5774e4c9b5486a04561920b
> 
>>
>>> narrowed the range). Also I'd recommend ensuring that the good kernel
>>> is really good and the bad kernel is really bad -- boot them a few
>>> times.
>>
>> Well, this problem is reproducible in 100% in newer kernels. I see the
>> errors on boot logs and after login to Gnome Shell the first execution
>> of xrandr (or opening a lid) hangs the system (the graphic card). On the
>> other side I haven't seen that problem in any earlier kernel. Therefore,
>> the situation is rather clear in my case. Nevertheless, I will stay with
>> that self-build good kernel (5.3.0-0.rc3 + git) to check it further.
>>
>>
>> How would you see it, Ilia? Is there anything in nouveau that needs to
>> be adjusted to that changes or rather those changes break something in
>> nouveau that would be best to fix/revert them (and it would be good to
>> let the committer know about the problem)?
>>
>> Marcin
>>
>>
>>
>>> On Mon, Dec 16, 2019 at 12:42 PM Marcin Zajączkowski <mszpak@wp.pl> wrote:
>>>>
>>>> On 2019-12-16 18:08, Ilia Mirkin wrote:
>>>>> Hi Marcin,
>>>>>
>>>>> You should do a git bisect rather than guessing about commits. I
>>>>> suspect that searching for "kernel git bisect fedora" should prove
>>>>> instructive if you're not sure how to do this.
>>>>
>>>> Thanks for your suggestion. I realize that I can do it at the Git level
>>>> and it is the ultimate way to go. However, building the kernel version
>>>> from sources takes some time (in addition to a regular time needed to
>>>> install/restart/verify which I already experienced narrowing down to a
>>>> "just" ~250 commits).
>>>>
>>>> Therefore, I would be really thankful for a suggestion which commits
>>>> could be good to check first - having 2, 4 is better than 8-10 (assuming
>>>> someone is right :) ).
>>>>
>>>> Marcin
>>>>
>>>>
>>>>
>>>>> On Mon, Dec 16, 2019 at 11:42 AM Marcin Zajączkowski <mszpak@wp.pl> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I've encountered a severe regression in TU116 (probably also TU117)
>>>>>> introduced in 5.3-rc4 (valid also for recent 5.4.2) [1]. The system
>>>>>> usually hangs on the subsequent graphic mode related operation (calling
>>>>>> xrandr after login is enough) with the following error:
>>>>>>
>>>>>>> kernel: nouveau 0000:01:00.0: fifo: SCHED_ERROR 08 []
>>>>>> ...
>>>>>>> kernel: nouveau 0000:01:00.0: DRM: failed to idle channel 0 [DRM]
>>>>>>> kernel: nouveau 0000:01:00.0: i2c: aux 0007: begin idle timeout ffffffff
>>>>>>> kernel: nouveau 0000:01:00.0: tmr: stalled at ffffffffffffffff
>>>>>>> kernel: ------------[ cut here ]------------
>>>>>>> kernel: nouveau 0000:01:00.0: timeout
>>>>>>> kernel: WARNING: CPU: 10 PID: 384 at drivers/gpu/drm/nouveau/nvkm/subdev/bar/g84.c:35 g84_bar_flush+0xcf/> 0xe0 [nouveau]
>>>>>>
>>>>>> (detailed log in a corresponding issue - [1])
>>>>>>
>>>>>> With earlier kernels there was no hardware acceleration for NVidia GTX
>>>>>> 1660 Ti, but at least I could use nouveau to disable it (to save
>>>>>> battery, trees and lower temperature) or even have an external output
>>>>>> (with Wayland). Now, the system is unusable with nouveau :(.
>>>>>>
>>>>>> I spent some time trying to narrow the scope using on the existing
>>>>>> kernel builds for Fedora. I was able to determine that the problem was
>>>>>> introduced between 5.3.0-0.rc3.git1.1 (commit 33920f1ec5bf - works fine)
>>>>>> and 5.3.0-0.rc4.git0.1 (tag v5.3-rc4 - fails with errors).
>>>>>>
>>>>>> It's just a few days (7-11 Aug) and "only" around 250 commits. I went
>>>>>> through them, but (based on the commits name) I haven't seen any nouveau
>>>>>> related changes and in general no very suspected drm related changes.
>>>>>>
>>>>>>> git log 33920f1ec5bf..v5.3-rc4 --stat
>>>>>>
>>>>>>
>>>>>> Maybe some of more nouveau/drm-experienced developers could take a look
>>>>>> at that to determine which commit could break it (to make it easier to
>>>>>> find out what should be fixed to prevent that regression)?
>>>>>>
>>>>>>
>>>>>> [1] -
>>>>>> https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau/issues/516
>>>>>>
>>>>>> Thanks in advance
>>>>>> Marcin
