Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1890A2F09BE
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jan 2021 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAJUxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jan 2021 15:53:43 -0500
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:57602 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbhAJUxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jan 2021 15:53:42 -0500
X-Greylist: delayed 668 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 15:53:39 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 007661801A880;
        Sun, 10 Jan 2021 20:42:35 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D6A10182CED28;
        Sun, 10 Jan 2021 20:41:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:69:152:327:355:379:901:960:966:967:973:982:988:989:1260:1261:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1801:2194:2196:2197:2198:2199:2200:2201:2202:2393:2525:2682:2685:2689:2693:2827:2859:2892:2894:2895:2897:2902:2924:2925:2926:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3657:3770:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:4423:4605:5007:6238:6742:6743:7514:7652:7808:7875:7903:7914:8501:8599:8603:8660:8957:8985:9010:9025:9072:9207:9388:9391:9855:10004:10049:10848:10967:11026:11232:11651:11657:11783:11854:11855:11914:12043:12050:12291:12296:12297:12305:12438:12555:12679:12683:12696:12737:12740:12776:12895:12986:13025:13129:13138:13141:13148:13149:13230:13231:13846:13894:13972:14094:14106:14394:14659:21080:21094:21221:21323:21324:21433:21450:21451:21483:21611:21627:21740:21781:21788:21
X-HE-Tag: table91_2a0c7af27507
X-Filterd-Recvd-Size: 36700
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Jan 2021 20:41:45 +0000 (UTC)
Message-ID: <77cdb7f32cfb087955bfc3600b86c40bed5d4104.camel@perches.com>
Subject: [PATCH] Documentation: Replace lkml.org links with lore
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        bhelgaas@google.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, m-karicheri2@ti.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, amurray@thegoodpenguin.co.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, hkallweit1@gmail.com,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Sun, 10 Jan 2021 12:41:44 -0800
In-Reply-To: <20200630140417.3a2dba67@lwn.net>
References: <20200627103050.71712-1-grandmaster@al2klimov.de>
         <20200630180917.GA3455699@bjorn-Precision-5520>
         <20200630140417.3a2dba67@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the lkml.org links with lore to better use a single source
that's more likely to stay available long-term.

Done by bash script:

cvt_lkml_to_lore ()
{
    tmpfile=$(mktemp ./.cvt_links.XXXXXXX)

    header=$(echo $1 | sed 's@/lkml/@/lkml/headers/@')

    wget -qO - $header > $tmpfile
    if [[ $? == 0 ]] ; then 
	link=$(grep -i '^Message-Id:' $tmpfile | head -1 | \
		   sed -r -e 's/^\s*Message-Id:\s*<\s*//' -e  's/\s*>\s*$//' -e 's@^@https://lore.kernel.org/r/@')
	#    echo "testlink: $link"
	if [ -n "$link" ] ; then
	    wget -qO - $link > /dev/null
	    if [[ $? == 0 ]] ; then
		echo $link
	    fi
	fi
    fi

    rm -f $tmpfile
}

git grep -P -o "\bhttps?://(?:www.)?lkml.org/lkml[\/\w]+" $@ |
    while read line ; do
	echo $line
	file=$(echo $line | cut -f1 -d':')
	link=$(echo $line | cut -f2- -d':')
	newlink=$(cvt_lkml_to_lore $link)
	if [[ -n "$newlink" ]] ; then
	    sed -i -e "s#\b$link\b#$newlink#" $file
	fi
    done

Link: https://lore.kernel.org/patchwork/patch/1265849/#1462688
Signed-off-by: Joe Perches <joe@perches.com>
---
On Tue, 2020-06-30 at 14:04 -0600, Jonathan Corbet wrote:
> On Tue, 30 Jun 2020 13:09:17 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > PCI: Replace lkml.org, spinics, gmane with lore.kernel.org
> > 
> > The lkml.org, spinics.net, and gmane.org archives are not very reliable
> > and, in some cases, not even easily accessible.  Replace links to them with
> > links to lore.kernel.org, the archives hosted by kernel.org.
> > 
> > I found the gmane items via the Wayback Machine archive at
> > https://web.archive.org/.
> 
> Heh...now *that* sounds like a project that could generate a lot of churn,
> and perhaps even be worth it.  Settling on a consistent (and working!)
> email archive would improve the docs quite a bit.  I'll add that to the
> list...

I just ran the script from last year again.

 Documentation/RCU/RTFP.txt                         | 94 +++++++++++-----------
 Documentation/accounting/cgroupstats.rst           |  4 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     | 14 ++--
 Documentation/admin-guide/cpu-load.rst             |  2 +-
 .../admin-guide/kernel-per-CPU-kthreads.rst        |  2 +-
 Documentation/driver-api/gpio/driver.rst           |  4 +-
 Documentation/gpu/todo.rst                         |  2 +-
 Documentation/power/freezing-of-tasks.rst          |  2 +-
 Documentation/process/adding-syscalls.rst          | 18 ++---
 Documentation/process/submitting-patches.rst       |  4 +-
 Documentation/scheduler/sched-deadline.rst         |  2 +-
 Documentation/security/lsm-development.rst         |  2 +-
 Documentation/timers/timers-howto.rst              |  2 +-
 .../translations/it_IT/process/adding-syscalls.rst | 18 ++---
 .../it_IT/process/submitting-patches.rst           |  4 +-
 Documentation/translations/ja_JP/SubmittingPatches |  4 +-
 .../translations/zh_CN/admin-guide/cpu-load.rst    |  2 +-
 .../zh_CN/process/submitting-patches.rst           |  4 +-
 18 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 9bccf16736f7..3b0876c77355 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -683,7 +683,7 @@ Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
 ,month="October"
 ,year="2001"
 ,note="Available:
-\url{http://lkml.org/lkml/2001/10/13/105}
+\url{https://lore.kernel.org/r/Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com}
 [Viewed August 21, 2004]"
 ,annotation={
 }
@@ -826,7 +826,7 @@ Symposium on Distributed Computing}
 ,month="October"
 ,year="2002"
 ,note="Available:
-\url{https://lkml.org/lkml/2002/10/24/262}
+\url{https://lore.kernel.org/r/3DB86B05.447E7410@us.ibm.com}
 [Viewed February 15, 2014]"
 ,annotation={
 	Mingming Cao's patch to introduce RCU to SysV IPC.
@@ -839,7 +839,7 @@ Symposium on Distributed Computing}
 ,month="March"
 ,year="2003"
 ,note="Available:
-\url{http://lkml.org/lkml/2003/3/9/205}
+\url{https://lore.kernel.org/r/Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com}
 [Viewed March 13, 2006]"
 ,annotation={
 	Linus suggests replacing brlock with RCU and/or seqlocks:
@@ -1036,15 +1036,15 @@ Add per-cpu batch counter"
 ,annotation={
 	RCU runs reasonably on a 512-CPU SGI using Manfred Spraul's patches,
 	which may be found at:
-	https://lkml.org/lkml/2004/5/20/49 (split vars into cachelines)
-	https://lkml.org/lkml/2004/5/22/114 (cpu_quiet() patch)
-	https://lkml.org/lkml/2004/5/25/24 (0/5)
-	https://lkml.org/lkml/2004/5/25/23 (1/5)
-		https://lkml.org/lkml/2004/5/25/265 (works for Jack)
-	https://lkml.org/lkml/2004/5/25/20 (2/5)
-	https://lkml.org/lkml/2004/5/25/22 (3/5)
-	https://lkml.org/lkml/2004/5/25/19 (4/5)
-	https://lkml.org/lkml/2004/5/25/21 (5/5)
+	https://lore.kernel.org/r/40AC9823.6020709@colorfullife.com (split vars into cachelines)
+	https://lore.kernel.org/r/Pine.LNX.4.44.0405222141260.11106-100000@dbl.q-ag.de (cpu_quiet() patch)
+	https://lore.kernel.org/r/200405250535.i4P5ZJo8017583@dbl.q-ag.de (0/5)
+	https://lore.kernel.org/r/200405250535.i4P5ZKAQ017591@dbl.q-ag.de (1/5)
+		https://lore.kernel.org/r/20040525203215.GB5127@sgi.com (works for Jack)
+	https://lore.kernel.org/r/200405250535.i4P5ZLiR017599@dbl.q-ag.de (2/5)
+	https://lore.kernel.org/r/200405250535.i4P5ZMFt017607@dbl.q-ag.de (3/5)
+	https://lore.kernel.org/r/200405250535.i4P5ZN6g017615@dbl.q-ag.de (4/5)
+	https://lore.kernel.org/r/200405250535.i4P5ZO7I017623@dbl.q-ag.de (5/5)
 }
 }
 
@@ -1106,7 +1106,7 @@ Oregon Health and Sciences University"
 ,month="August"
 ,year="2004"
 ,note="Available:
-\url{http://lkml.org/lkml/2004/8/6/237}
+\url{https://lore.kernel.org/r/20040807192424.GF3936@in.ibm.com}
 [Viewed June 8, 2010]"
 ,annotation={
 	Introduce rcu_dereference().
@@ -1119,7 +1119,7 @@ Oregon Health and Sciences University"
 ,month="August"
 ,year="2004"
 ,note="Available:
-\url{http://lkml.org/lkml/2004/8/30/87}
+\url{https://lore.kernel.org/r/1093873222.984.12.camel@new.localdomain}
 [Viewed February 17, 2005]"
 ,annotation={
 	Uses active code in rcu_read_lock() and rcu_read_unlock() to
@@ -1186,7 +1186,7 @@ Oregon Health and Sciences University"
 ,month="October"
 ,year="2004"
 ,note="Available:
-\url{http://lkml.org/lkml/2004/10/23/241}
+\url{https://lore.kernel.org/r/20041023202723.GA1930@us.ibm.com}
 [Viewed June 8, 2010]"
 ,annotation={
 	Introduce rcu_assign_pointer().
@@ -1203,7 +1203,7 @@ Oregon Health and Sciences University"
 ,annotation={
 	James Morris posts Kaigai Kohei's patch to LKML.
 	[Viewed December 10, 2004]
-	Kaigai's patch is at https://lkml.org/lkml/2004/9/27/52
+	Kaigai's patch is at https://lore.kernel.org/r/200409271057.i8RAvcA1007873@mailsv.bs1.fc.nec.co.jp
 }
 }
 
@@ -1241,7 +1241,7 @@ Oregon Health and Sciences University"
 ,year="2005"
 ,day="17"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/3/17/199}
+\url{https://lore.kernel.org/r/20050318002026.GA2693@us.ibm.com}
 [Viewed September 5, 2005]"
 ,annotation={
 	First posting showing how RCU can be safely adapted for
@@ -1256,7 +1256,7 @@ Oregon Health and Sciences University"
 ,year="2005"
 ,day="18"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/3/18/122}
+\url{https://lore.kernel.org/r/Pine.OSF.4.05.10503181336310.2466-100000@da410.phys.au.dk}
 [Viewed March 30, 2006]"
 ,annotation={
 	Esben Neilsen suggests read-side suppression of grace-period
@@ -1302,7 +1302,7 @@ Data Structures"
 ,month="May"
 ,year="2005"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/5/9/185}
+\url{https://lore.kernel.org/r/20050510012444.GA3011@us.ibm.com}
 [Viewed May 13, 2005]"
 ,annotation={
 	First publication of working lock-based deferred free patches
@@ -1385,7 +1385,7 @@ Data Structures"
 ,day="1"
 ,year="2005"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/8/1/155}
+\url{https://lore.kernel.org/r/20050801171137.GA1754@us.ibm.com}
 [Viewed March 14, 2006]"
 ,annotation={
 	First operating counter-based realtime RCU patch posted to LKML.
@@ -1399,7 +1399,7 @@ Data Structures"
 ,day="8"
 ,year="2005"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/8/8/108}
+\url{https://lore.kernel.org/r/20050808144216.GA1307@us.ibm.com}
 [Viewed March 14, 2006]"
 ,annotation={
 	First operating counter-based realtime RCU patch posted to LKML,
@@ -1415,7 +1415,7 @@ Data Structures"
 ,day="1"
 ,year="2005"
 ,note="Available:
-\url{http://lkml.org/lkml/2005/10/1/70}
+\url{https://lore.kernel.org/r/20051001182056.GA1613@us.ibm.com}
 [Viewed March 14, 2006]"
 ,annotation={
 	First rcutorture patch.
@@ -1429,7 +1429,7 @@ Data Structures"
 ,day="6"
 ,year="2006"
 ,note="Available:
-\url{https://lkml.org/lkml/2006/1/7/22}
+\url{https://lore.kernel.org/r/20060106.231054.43576567.davem@davemloft.net}
 [Viewed February 29, 2012]"
 ,annotation={
 	David Miller's view on hashed arrays of locks: used to really
@@ -1464,7 +1464,7 @@ Distributed Processing Symposium"
 ,day="20"
 ,year="2006"
 ,note="Available:
-\url{http://lkml.org/lkml/2006/6/20/238}
+\url{https://lore.kernel.org/r/20060408134707.22479.33814.sendpatchset@linux.site}
 [Viewed March 25, 2008]"
 ,annotation={
 	RCU-protected radix tree.
@@ -1554,7 +1554,7 @@ Revised:
 ,day="28"
 ,year="2006"
 ,note="Available:
-\url{http://lkml.org/lkml/2006/9/28/160}
+\url{https://lore.kernel.org/r/20060928142616.GA20185@infradead.org}
 [Viewed March 27, 2008]"
 }
 
@@ -1593,7 +1593,7 @@ Revised:
 ,year="2006"
 ,day=26
 ,note="Available:
-\url{http://lkml.org/lkml/2006/10/26/73}
+\url{https://lore.kernel.org/r/20061026105731.GE11803@in.ibm.com}
 [Viewed January 26, 2009]"
 ,annotation={
 	RCU-based reader-writer lock that allows readers to proceed with
@@ -1612,12 +1612,12 @@ Revised:
 ,year="2006"
 ,day=17
 ,note="Available:
-\url{http://lkml.org/lkml/2006/11/17/56}
+\url{https://lore.kernel.org/r/20061117092925.GT7164@kernel.dk}
 [Viewed May 28, 2007]"
 ,annotation={
 	SRCU's grace periods are too slow for Jens, even after a
 	factor-of-three speedup.
-	Sped-up version of SRCU at http://lkml.org/lkml/2006/11/17/359.
+	Sped-up version of SRCU at https://lore.kernel.org/r/20061118002845.GF2632@us.ibm.com.
 }
 }
 
@@ -1629,7 +1629,7 @@ Revised:
 ,year="2006"
 ,day=19
 ,note="Available:
-\url{http://lkml.org/lkml/2006/11/19/69}
+\url{https://lore.kernel.org/r/20061119190027.GA3676@oleg}
 [Viewed May 28, 2007]"
 ,annotation={
 	First cut of QRCU.  Expanded/corrected versions followed.
@@ -1644,7 +1644,7 @@ Revised:
 ,year="2006"
 ,day=30
 ,note="Available:
-\url{http://lkml.org/lkml/2006/11/29/330}
+\url{https://lore.kernel.org/r/20061130015714.GC1350@oleg}
 [Viewed November 26, 2008]"
 ,annotation={
 	Expanded/corrected version of QRCU.
@@ -1709,7 +1709,7 @@ Revised:
 ,year="2007"
 ,day=3
 ,note="Available:
-\url{http://lkml.org/lkml/2007/1/3/112}
+\url{https://lore.kernel.org/r/20070103152738.GA16063@localdomain}
 [Viewed May 28, 2007]"
 ,annotation={
 	Patch for list_splice_rcu().
@@ -1737,7 +1737,7 @@ Revised:
 ,year="2007"
 ,day=28
 ,note="Available:
-\url{http://lkml.org/lkml/2007/1/28/34}
+\url{https://lore.kernel.org/r/20070128120509.719287000@programming.kicks-ass.net}
 [Viewed March 27, 2008]"
 ,annotation={
 	RCU-like implementation for frequent updaters and rare readers(!).
@@ -1767,7 +1767,7 @@ Revised:
 ,year="2007"
 ,day=24
 ,note="Available:
-\url{http://lkml.org/lkml/2007/2/25/18}
+\url{https://lore.kernel.org/r/20070225062349.GA17468@linux.vnet.ibm.com}
 [Viewed March 27, 2008]"
 ,annotation={
 	Patch for QRCU supplying lock-free fast path.
@@ -1846,7 +1846,7 @@ Revised:
 ,annotation={
 	LWN article describing Promela and spin, and also using Oleg
 	Nesterov's QRCU as an example (with Paul McKenney's fastpath).
-	Merged patch at: http://lkml.org/lkml/2007/2/25/18
+	Merged patch at: https://lore.kernel.org/r/20070225062349.GA17468@linux.vnet.ibm.com
 }
 }
 
@@ -1885,7 +1885,7 @@ Revised:
 ,day="10"
 ,year="2007"
 ,note="Available:
-\url{http://lkml.org/lkml/2007/9/10/213}
+\url{https://lore.kernel.org/r/20070910183004.GA3299@linux.vnet.ibm.com}
 [Viewed October 25, 2007]"
 ,annotation={
 	Final patch for preemptable RCU to -rt.  (Later patches were
@@ -1933,7 +1933,7 @@ Revised:
 ,day="20"
 ,year="2007"
 ,note="Available:
-\url{http://lkml.org/lkml/2007/12/20/244}
+\url{https://lore.kernel.org/r/20071220142540.GB22523@Krystal}
 [Viewed March 27, 2008]"
 ,annotation={
 	Request for call_rcu_sched() and rcu_barrier_sched().
@@ -2013,7 +2013,7 @@ Revised:
 ,day="29"
 ,year="2008"
 ,note="Available:
-\url{http://lkml.org/lkml/2008/1/29/208}
+\url{https://lore.kernel.org/r/Pine.LNX.4.58.0801291113350.20371@gandalf.stny.rr.com}
 [Viewed March 27, 2008]"
 ,annotation={
 	Patch that prevents preemptible RCU from unnecessarily waking
@@ -2028,7 +2028,7 @@ Revised:
 ,day="1"
 ,year="2008"
 ,note="Available:
-\url{http://lkml.org/lkml/2008/2/2/255}
+\url{https://lore.kernel.org/r/20080202214124.GA28612@linux.vnet.ibm.com}
 [Viewed October 18, 2008]"
 ,annotation={
 	Explanation of compilers violating dependency ordering.
@@ -2088,7 +2088,7 @@ lot of {Linux} into your technology!!!"
 ,day="3"
 ,year="2008"
 ,note="Available:
-\url{http://lkml.org/lkml/2008/6/2/539}
+\url{https://lore.kernel.org/r/4844BE83.5010401@cn.fujitsu.com}
 [Viewed December 10, 2008]"
 ,annotation={
 	Updated RCU classic algorithm.  Introduced multi-tailed list
@@ -2122,7 +2122,7 @@ lot of {Linux} into your technology!!!"
 ,day="21"
 ,year="2008"
 ,note="Available:
-\url{http://lkml.org/lkml/2008/8/21/336}
+\url{https://lore.kernel.org/r/48AD8969.7060900@colorfullife.com}
 [Viewed December 8, 2008]"
 ,annotation={
 	State-based RCU.  One key thing that this patch does is to
@@ -2137,7 +2137,7 @@ lot of {Linux} into your technology!!!"
 ,day="6"
 ,year="2008"
 ,note="Available:
-\url{http://lkml.org/lkml/2008/9/6/86}
+\url{https://lore.kernel.org/r/48C2B1D2.5070801@colorfullife.com}
 [Viewed December 8, 2008]"
 ,annotation={
 	Manfred notes a fix required to my attempt to separate irq
@@ -2183,7 +2183,7 @@ lot of {Linux} into your technology!!!"
 ,day="14"
 ,year="2009"
 ,note="Available:
-\url{http://lkml.org/lkml/2009/1/14/449}
+\url{https://lore.kernel.org/r/20090114202044.GJ6734@linux.vnet.ibm.com}
 [Viewed January 15, 2009]"
 ,annotation={
 	Small-footprint implementation of RCU for uniprocessor
@@ -2218,7 +2218,7 @@ lot of {Linux} into your technology!!!"
 	git://lttng.org/userspace-rcu.git
 	http://lttng.org/cgi-bin/gitweb.cgi?p=userspace-rcu.git
 	http://lttng.org/urcu
-	http://lkml.org/lkml/2009/2/5/572
+	https://lore.kernel.org/r/20090206030543.GB8560@Krystal
 }
 }
 
@@ -2258,7 +2258,7 @@ lot of {Linux} into your technology!!!"
 ,day="25"
 ,year="2009"
 ,note="Available:
-\url{http://lkml.org/lkml/2009/6/25/306}
+\url{https://lore.kernel.org/r/20090625160706.GA9467@linux.vnet.ibm.com}
 [Viewed August 16, 2009]"
 ,annotation={
 	First posting of expedited RCU to be accepted into -tip.
@@ -2272,7 +2272,7 @@ lot of {Linux} into your technology!!!"
 ,day="23"
 ,year="2009"
 ,note="Available:
-\url{http://lkml.org/lkml/2009/7/23/294}
+\url{https://lore.kernel.org/r/20090724001429.GA17374@linux.vnet.ibm.com}
 [Viewed August 15, 2009]"
 ,annotation={
 	First posting of simple and fast preemptable RCU.
@@ -2350,7 +2350,7 @@ lot of {Linux} into your technology!!!"
 ,month="December"
 ,year="2009"
 ,note="Available:
-\url{http://lkml.org/lkml/2009/10/18/129}
+\url{https://lore.kernel.org/r/20091018232918.GA7385@Krystal}
 [Viewed December 29, 2009]"
 ,annotation={
 	Mathieu proposed defer_rcu() with fixed-size per-thread pool
@@ -2518,7 +2518,7 @@ lot of {Linux} into your technology!!!"
 ,month="January"
 ,year="2011"
 ,note="Available:
-\url{https://lkml.org/lkml/2011/1/18/322}
+\url{https://lore.kernel.org/r/AANLkTimajU0x1v6y3rH2+jr-bZ=tNLs1S_agXdGGAa3S@mail.gmail.com}
 [Viewed March 4, 2011]"
 ,annotation={
 	"The RCU-based name lookup is at the other end of the spectrum - the
diff --git a/Documentation/accounting/cgroupstats.rst b/Documentation/accounting/cgroupstats.rst
index b9afc48f4ea2..85186e7d4035 100644
--- a/Documentation/accounting/cgroupstats.rst
+++ b/Documentation/accounting/cgroupstats.rst
@@ -3,8 +3,8 @@ Control Groupstats
 ==================
 
 Control Groupstats is inspired by the discussion at
-http://lkml.org/lkml/2007/4/11/187 and implements per cgroup statistics as
-suggested by Andrew Morton in http://lkml.org/lkml/2007/4/11/263.
+https://lore.kernel.org/r/461CF883.2030308@sw.ru and implements per cgroup statistics as
+suggested by Andrew Morton in https://lore.kernel.org/r/20070411114927.1277d7c9.akpm@linux-foundation.org.
 
 Per cgroup statistics infrastructure re-uses code from the taskstats
 interface. A new set of cgroup operations are registered with commands
diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 52688ae34461..0936412e044e 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -963,21 +963,21 @@ References
 2. Singh, Balbir. Memory Controller (RSS Control),
    http://lwn.net/Articles/222762/
 3. Emelianov, Pavel. Resource controllers based on process cgroups
-   http://lkml.org/lkml/2007/3/6/198
+   https://lore.kernel.org/r/45ED7DEC.7010403@sw.ru
 4. Emelianov, Pavel. RSS controller based on process cgroups (v2)
-   http://lkml.org/lkml/2007/4/9/78
+   https://lore.kernel.org/r/461A3010.90403@sw.ru
 5. Emelianov, Pavel. RSS controller based on process cgroups (v3)
-   http://lkml.org/lkml/2007/5/30/244
+   https://lore.kernel.org/r/465D9739.8070209@openvz.org
 6. Menage, Paul. Control Groups v10, http://lwn.net/Articles/236032/
 7. Vaidyanathan, Srinivasan, Control Groups: Pagecache accounting and control
    subsystem (v3), http://lwn.net/Articles/235534/
 8. Singh, Balbir. RSS controller v2 test results (lmbench),
-   http://lkml.org/lkml/2007/5/17/232
+   https://lore.kernel.org/r/464C95D4.7070806@linux.vnet.ibm.com
 9. Singh, Balbir. RSS controller v2 AIM9 results
-   http://lkml.org/lkml/2007/5/18/1
+   https://lore.kernel.org/r/464D267A.50107@linux.vnet.ibm.com
 10. Singh, Balbir. Memory controller v6 test results,
-    http://lkml.org/lkml/2007/8/19/36
+    https://lore.kernel.org/r/20070819094658.654.84837.sendpatchset@balbir-laptop
 11. Singh, Balbir. Memory controller introduction (v6),
-    http://lkml.org/lkml/2007/8/17/69
+    https://lore.kernel.org/r/20070817084228.26003.12568.sendpatchset@balbir-laptop
 12. Corbet, Jonathan, Controlling memory use in cgroups,
     http://lwn.net/Articles/243795/
diff --git a/Documentation/admin-guide/cpu-load.rst b/Documentation/admin-guide/cpu-load.rst
index f3ada90e9ca8..21a984337080 100644
--- a/Documentation/admin-guide/cpu-load.rst
+++ b/Documentation/admin-guide/cpu-load.rst
@@ -107,7 +107,7 @@ will lead to quite erratic information inside ``/proc/stat``::
 References
 ----------
 
-- http://lkml.org/lkml/2007/2/12/6
+- https://lore.kernel.org/r/loom.20070212T063225-663@post.gmane.org
 - Documentation/filesystems/proc.rst (1.8)
 
 
diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index dc36aeb65d0a..531f689311f2 100644
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -273,7 +273,7 @@ To reduce its OS jitter, do any of the following:
 		However, there is an RFC patch from Christoph Lameter
 		(based on an earlier one from Gilad Ben-Yossef) that
 		reduces or even eliminates vmstat overhead for some
-		workloads at https://lkml.org/lkml/2013/9/4/379.
+		workloads at https://lore.kernel.org/r/00000140e9dfd6bd-40db3d4f-c1be-434f-8132-7820f81bb586-000000@email.amazonses.com.
 	e.	If running on high-end powerpc servers, build with
 		CONFIG_PPC_RTAS_DAEMON=n.  This prevents the RTAS
 		daemon from running on each CPU every second or so.
diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 0fb57e298b41..d6b0d779859b 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -640,8 +640,8 @@ compliance:
   level and edge IRQs
 
 * [1] http://www.spinics.net/lists/linux-omap/msg120425.html
-* [2] https://lkml.org/lkml/2015/9/25/494
-* [3] https://lkml.org/lkml/2015/9/25/495
+* [2] https://lore.kernel.org/r/1443209283-20781-2-git-send-email-grygorii.strashko@ti.com
+* [3] https://lore.kernel.org/r/1443209283-20781-3-git-send-email-grygorii.strashko@ti.com
 
 
 Requesting self-owned GPIO pins
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 009d8e6c7e3c..d42c22567c5d 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -669,7 +669,7 @@ for fbdev.
   https://patchwork.freedesktop.org/patch/306579/
 
 - [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lkml.org/lkml/2017/12/13/764
+  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
 
 Contact: Sam Ravnborg
 
diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/power/freezing-of-tasks.rst
index 8bd693399834..53b6a56c4635 100644
--- a/Documentation/power/freezing-of-tasks.rst
+++ b/Documentation/power/freezing-of-tasks.rst
@@ -134,7 +134,7 @@ Generally speaking, there is a couple of reasons to use the freezing of tasks:
    safeguards against race conditions that might occur in such a case.
 
 Although Linus Torvalds doesn't like the freezing of tasks, he said this in one
-of the discussions on LKML (http://lkml.org/lkml/2007/4/27/608):
+of the discussions on LKML (https://lore.kernel.org/r/alpine.LFD.0.98.0704271801020.9964@woody.linux-foundation.org):
 
 "RJW:> Why we freeze tasks at all or why we freeze kernel threads?
 
diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index a3ecb236576c..02857b5ad2b5 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -548,18 +548,18 @@ References and Sources
    https://lwn.net/Articles/486306/
  - Recommendation from Andrew Morton that all related information for a new
    system call should come in the same email thread:
-   https://lkml.org/lkml/2014/7/24/641
+   https://lore.kernel.org/r/20140724144747.3041b208832bbdf9fbce5d96@linux-foundation.org
  - Recommendation from Michael Kerrisk that a new system call should come with
-   a man page: https://lkml.org/lkml/2014/6/13/309
+   a man page: https://lore.kernel.org/r/CAKgNAkgMA39AfoSoA5Pe1r9N+ZzfYQNvNPvcRN7tOvRb8+v06Q@mail.gmail.com
  - Suggestion from Thomas Gleixner that x86 wire-up should be in a separate
-   commit: https://lkml.org/lkml/2014/11/19/254
+   commit: https://lore.kernel.org/r/alpine.DEB.2.11.1411191249560.3909@nanos
  - Suggestion from Greg Kroah-Hartman that it's good for new system calls to
-   come with a man-page & selftest: https://lkml.org/lkml/2014/3/19/710
+   come with a man-page & selftest: https://lore.kernel.org/r/20140320025530.GA25469@kroah.com
  - Discussion from Michael Kerrisk of new system call vs. :manpage:`prctl(2)` extension:
-   https://lkml.org/lkml/2014/6/3/411
+   https://lore.kernel.org/r/CAHO5Pa3F2MjfTtfNxa8LbnkeeU8=YJ+9tDqxZpw7Gz59E-4AUg@mail.gmail.com
  - Suggestion from Ingo Molnar that system calls that involve multiple
    arguments should encapsulate those arguments in a struct, which includes a
-   size field for future extensibility: https://lkml.org/lkml/2015/7/30/117
+   size field for future extensibility: https://lore.kernel.org/r/20150730083831.GA22182@gmail.com
  - Numbering oddities arising from (re-)use of O_* numbering space flags:
 
     - commit 75069f2b5bfb ("vfs: renumber FMODE_NONOTIFY and add to uniqueness
@@ -569,9 +569,9 @@ References and Sources
     - commit bb458c644a59 ("Safer ABI for O_TMPFILE")
 
  - Discussion from Matthew Wilcox about restrictions on 64-bit arguments:
-   https://lkml.org/lkml/2008/12/12/187
+   https://lore.kernel.org/r/20081212152929.GM26095@parisc-linux.org
  - Recommendation from Greg Kroah-Hartman that unknown flags should be
-   policed: https://lkml.org/lkml/2014/7/17/577
+   policed: https://lore.kernel.org/r/20140717193330.GB4703@kroah.com
  - Recommendation from Linus Torvalds that x32 system calls should prefer
    compatibility with 64-bit versions rather than 32-bit versions:
-   https://lkml.org/lkml/2011/8/31/244
+   https://lore.kernel.org/r/CA+55aFxfmwfB7jbbrXxa=K7VBYPfAvmu3XOkGrLbB1UFjX1+Ew@mail.gmail.com
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 5ba54120bef7..7c97ad580e7d 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -769,13 +769,13 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
-  <https://lkml.org/lkml/2005/7/11/336>
+  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
 Kernel Documentation/process/coding-style.rst:
   :ref:`Documentation/process/coding-style.rst <codingstyle>`
 
 Linus Torvalds's mail on the canonical patch format:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
 
 Andi Kleen, "On submitting kernel patches"
   Some strategies to get difficult or controversial changes in.
diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 14a2f7bf63fe..9d9be52f221a 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -707,7 +707,7 @@ Deadline Task Scheduling
     and how to prevent non-root users "cheat" the system?
 
  As already discussed, we are planning also to merge this work with the EDF
- throttling patches [https://lkml.org/lkml/2010/2/23/239] but we still are in
+ throttling patches [https://lore.kernel.org/r/cover.1266931410.git.fabio@helm.retis] but we still are in
  the preliminary phases of the merge and we really seek feedback that would
  help us decide on the direction it should take.
 
diff --git a/Documentation/security/lsm-development.rst b/Documentation/security/lsm-development.rst
index 31d92bc5fdd2..ac53e5065f79 100644
--- a/Documentation/security/lsm-development.rst
+++ b/Documentation/security/lsm-development.rst
@@ -2,7 +2,7 @@
 Linux Security Module Development
 =================================
 
-Based on https://lkml.org/lkml/2007/10/26/215,
+Based on https://lore.kernel.org/r/20071026073721.618b4778@laptopd505.fenrus.org,
 a new LSM is accepted into the kernel when its intent (a description of
 what it tries to protect against and in what cases one would expect to
 use it) has been appropriately documented in ``Documentation/admin-guide/LSM/``.
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/timers-howto.rst
index afb0a43b8cdf..5c169e3d29a8 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -75,7 +75,7 @@ NON-ATOMIC CONTEXT:
 
 		- Why not msleep for (1ms - 20ms)?
 			Explained originally here:
-				http://lkml.org/lkml/2007/8/3/250
+				https://lore.kernel.org/r/15327.1186166232@lwn.net
 
 			msleep(1~20) may not do what the caller intends, and
 			will often sleep longer (~20 ms actual sleep for any
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index bff0a82bf127..c478b6e8c292 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -611,21 +611,21 @@ Riferimenti e fonti
    https://lwn.net/Articles/486306/
  - Raccomandazioni da Andrew Morton circa il fatto che tutte le informazioni
    su una nuova chiamata di sistema dovrebbero essere contenute nello stesso
-   filone di discussione di email: https://lkml.org/lkml/2014/7/24/641
+   filone di discussione di email: https://lore.kernel.org/r/20140724144747.3041b208832bbdf9fbce5d96@linux-foundation.org
  - Raccomandazioni da Michael Kerrisk circa il fatto che le nuove chiamate di
-   sistema dovrebbero avere una pagina man: https://lkml.org/lkml/2014/6/13/309
+   sistema dovrebbero avere una pagina man: https://lore.kernel.org/r/CAKgNAkgMA39AfoSoA5Pe1r9N+ZzfYQNvNPvcRN7tOvRb8+v06Q@mail.gmail.com
  - Consigli da Thomas Gleixner sul fatto che il collegamento all'architettura
    x86 dovrebbe avvenire in un *commit* differente:
-   https://lkml.org/lkml/2014/11/19/254
+   https://lore.kernel.org/r/alpine.DEB.2.11.1411191249560.3909@nanos
  - Consigli da Greg Kroah-Hartman circa la bontà d'avere una pagina man e un
    programma di auto-verifica per le nuove chiamate di sistema:
-   https://lkml.org/lkml/2014/3/19/710
+   https://lore.kernel.org/r/20140320025530.GA25469@kroah.com
  - Discussione di Michael Kerrisk sulle nuove chiamate di sistema contro
-   le estensioni :manpage:`prctl(2)`: https://lkml.org/lkml/2014/6/3/411
+   le estensioni :manpage:`prctl(2)`: https://lore.kernel.org/r/CAHO5Pa3F2MjfTtfNxa8LbnkeeU8=YJ+9tDqxZpw7Gz59E-4AUg@mail.gmail.com
  - Consigli da Ingo Molnar che le chiamate di sistema con più argomenti
    dovrebbero incapsularli in una struttura che includa un argomento
    *size* per garantire l'estensibilità futura:
-   https://lkml.org/lkml/2015/7/30/117
+   https://lore.kernel.org/r/20150730083831.GA22182@gmail.com
  - Un certo numero di casi strani emersi dall'uso (riuso) dei flag O_*:
 
     - commit 75069f2b5bfb ("vfs: renumber FMODE_NONOTIFY and add to uniqueness
@@ -635,9 +635,9 @@ Riferimenti e fonti
     - commit bb458c644a59 ("Safer ABI for O_TMPFILE")
 
  - Discussion from Matthew Wilcox about restrictions on 64-bit arguments:
-   https://lkml.org/lkml/2008/12/12/187
+   https://lore.kernel.org/r/20081212152929.GM26095@parisc-linux.org
  - Raccomandazioni da Greg Kroah-Hartman sul fatto che i flag sconosciuti dovrebbero
-   essere controllati: https://lkml.org/lkml/2014/7/17/577
+   essere controllati: https://lore.kernel.org/r/20140717193330.GB4703@kroah.com
  - Raccomandazioni da Linus Torvalds che le chiamate di sistema x32 dovrebbero
    favorire la compatibilità con le versioni a 64-bit piuttosto che quelle a 32-bit:
-   https://lkml.org/lkml/2011/8/31/244
+   https://lore.kernel.org/r/CA+55aFxfmwfB7jbbrXxa=K7VBYPfAvmu3XOkGrLbB1UFjX1+Ew@mail.gmail.com
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 966cd3242a60..ae00352346ed 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -731,13 +731,13 @@ Greg Kroah-Hartman, "Come scocciare un manutentore di un sottosistema"
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
 No!!!! Basta gigantesche bombe patch alle persone sulla lista linux-kernel@vger.kernel.org!
-  <https://lkml.org/lkml/2005/7/11/336>
+  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
 Kernel Documentation/translations/it_IT/process/coding-style.rst:
   :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`
 
 E-mail di Linus Torvalds sul formato canonico di una patch:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
 
 Andi Kleen, "Su come sottomettere patch del kernel"
   Alcune strategie su come sottomettere modifiche toste o controverse.
diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index dd0c3280ba5a..6854f5add72e 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -702,13 +702,13 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/2006/01/11/>
 
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
-  <https://lkml.org/lkml/2005/7/11/336>
+  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
 Kernel Documentation/process/coding-style.rst:
   <http://users.sosdg.org/~qiyong/lxr/source/Documentation/process/coding-style.rst>
 
 Linus Torvalds's mail on the canonical patch format:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
 
 Andi Kleen, "On submitting kernel patches"
   Some strategies to get difficult or controversial changes in.
diff --git a/Documentation/translations/zh_CN/admin-guide/cpu-load.rst b/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
index c972731c0e57..a73400a054ff 100644
--- a/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_CN/admin-guide/cpu-load.rst
@@ -95,7 +95,7 @@ Linux通过``/proc/stat``和``/proc/uptime``导出各种信息，用户空间工
 参考
 ---
 
-- http://lkml.org/lkml/2007/2/12/6
+- https://lore.kernel.org/r/loom.20070212T063225-663@post.gmane.org
 - Documentation/filesystems/proc.rst (1.8)
 
 
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 2e7dbaad4028..4fc6d16f5196 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -668,13 +668,13 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
-  <https://lkml.org/lkml/2005/7/11/336>
+  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
 Kernel Documentation/process/coding-style.rst:
   :ref:`Documentation/translations/zh_CN/process/coding-style.rst <cn_codingstyle>`
 
 Linus Torvalds's mail on the canonical patch format:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
 
 Andi Kleen, "On submitting kernel patches"
   Some strategies to get difficult or controversial changes in.


